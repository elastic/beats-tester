@Library('apm@current') _

pipeline {
  agent { label 'master' }
  environment {
    PIPELINE_LOG_LEVEL = 'INFO'
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
  }
  stages {
    stage('Run Tasks'){
      steps {
        build(job: 'Beats/beats-tester-mbp/master',
              parameters: [
                // Matches the upcoming release. So it should be changed with the upcoming releases.
                string(name: 'VERSION', value: '7.9'),
              ],
              propagate: false,
              wait: false)
      }
    }
  }
  post {
    cleanup {
      notifyBuildResult()
    }
  }
}
