// Licensed to Elasticsearch B.V. under one or more contributor
// license agreements. See the NOTICE file distributed with
// this work for additional information regarding copyright
// ownership. Elasticsearch B.V. licenses this file to you under
// the Apache License, Version 2.0 (the "License"); you may
// not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

@Library('apm@current') _

pipeline {
  agent { label 'master' }
  environment {
    NOTIFY_TO = credentials('notify-to')
    PIPELINE_LOG_LEVEL = 'INFO'
    BEATS_TESTER_JOB = 'Beats/beats-tester-mbp/master'
    VERSION = '8.0.0-SNAPSHOT'
    NEW_CHANGES = 'false'
  }
  options {
    timeout(time: 1, unit: 'HOURS')
    buildDiscarder(logRotator(numToKeepStr: '20', artifactNumToKeepStr: '20'))
    timestamps()
    ansiColor('xterm')
    disableResume()
    durabilityHint('PERFORMANCE_OPTIMIZED')
  }
  triggers {
    cron('H H(4-5) * * 1-5')
    upstream('Beats/beats/master')
  }
  stages {
    stage('Run Tasks on a cron basis'){
      when {
        triggeredBy 'TimerTrigger'
      }
      steps {
        runBeatsTesterJob()
      }
    }
    stage('Upstream setup') {
      when {
        triggeredBy 'UpstreamCause'
      }
      steps {
        git 'https://github.com/elastic/beats-tester.git'
        sh(label: 'Get snapshot metadata', script: ".ci/scripts/fetch-metadata.sh ${VERSION}")
        // Archive metadata to be compared in the upstream setup stage.
        archiveArtifacts(allowEmptyArchive: false, artifacts: 'metadata.txt')
        copyArtifacts(projectName: env.BEATS_TESTER_JOB, filter: 'metadata.txt', target: 'previous', optional: true)
        whenTrue(fileExists('previous/metadata.txt')) {
          script {
            env.NEW_CHANGES = sh(label: 'Compare metadata', returnStdout: true,
                                script: 'cmp metadata.txt previous/metadata.txt && echo "false" || echo "true"')?.trim()
            env.BC_ID = sh(script: '.ci/scripts/get-build-id.sh metadata.txt', returnStdout: true)?.trim()
          }
        }        
      }
    }
    stage('Run Tasks on an Upstream basis if new BC'){
      when {
        allOf {
          triggeredBy 'UpstreamCause'
          expression { env.NEW_CHANGES == 'true' }
        }
      }
      steps {
        runBeatsTesterJob(apm: "https://staging.elastic.co/${env.BC_ID}/downloads/apm-server",
                          beats: "https://staging.elastic.co/${env.BC_ID}/downloads/beats")
      }
    }
    stage('Run Tasks on an Upstream basis if no BC'){
      when {
        allOf {
          triggeredBy 'UpstreamCause'
          expression { env.NEW_CHANGES == 'false' }
        }
      }
      steps {
        runBeatsTesterJob()
      }
    }
  }
  post {
    cleanup {
      notifyBuildResult(prComment: false)
    }
  }
}

def runBeatsTesterJob(Map args = [:]) {
  if (args.apm && args.beats) {
    build(job: env.BEATS_TESTER_JOB, propagate: false, wait: false,
          parameters: [
            string(name: 'APM_URL_BASE', value: args.apm),
            string(name: 'BEATS_URL_BASE', value: args.beats),
            string(name: 'VERSION', value: env.VERSION)
          ])
  } else {
    build(job: env.BEATS_TESTER_JOB, propagate: false, wait: false, parameters: [ string(name: 'VERSION', value: env.VERSION) ])
  }
}