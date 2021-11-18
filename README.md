# The Beats Tester

Vagrant + Ansible setup for testing the OS packages and basic e2e tests for all
the [Beats](https://www.elastic.co/products/beats).

## OS matrix

  OS | Support
---- | -------
awslinux | :white_check_mark:
awslinux2 | :white_check_mark:
centos7-64 | :white_check_mark:
centos8-64 | :white_check_mark:
debian10-64 | :white_check_mark:
debian8-64 | :white_check_mark:
debian9-64 | :white_check_mark:
sles12-64 | :white_check_mark:
ubuntu1804-64 | :white_check_mark:
ubuntu2004-64 | :white_check_mark:
win12-64 | :white_check_mark:
win16-64 | :white_check_mark:
win19-64 | :white_check_mark:

## Execute

First, you need to bring the machines up:

    make setup

Then you can use Ansible to run the tests. Because they involve lots of VMs and
commands executed over SSH, these tests are slow (currently 15 minutes in
total). However, while creating tests or checking something quickly, you can use
different Ansible commands to execute only a subset.

Here are some execution examples:

* Test the most recent [nightly builds](https://internal-ci.elastic.co/job/elastic+release-manager+master+unified-snapshot/) (excluding OS X):

        RUN_SETTINGS=snapshot make run

* All tests, all platforms, a particular release:

        # Edit version contained in run-settings-released.yml.
        RUN_SETTINGS=released make run

* Only a particular Beat, Packetbeat in the example:

        export ANSIBLE_EXTRA_FLAGS="--tags packetbeat"
        make run

* Only a particular OS, Debian 8 amd64 in the example:

        # Instead using 'make setup' launch vagrant machines manually.
        machine=tester-debian8-64
        vagrant up $machine
        vagrant ssh-config $machine > ssh_config
        export ANSIBLE_LIMIT="$machine"
        make run

* Only a set of ansible groups in batches:

        # Run tests in batches for all hosts
        make batch

        # Run tests in batches for all Linux hosts
        GROUPS='centos debian sles' make batch

        # Run tests in batches for all Debian hosts
        GROUPS=debian make batch

        # Run tests in batches for Windows hosts
        GROUPS=windows make batch

* Enable Ansible debug.

        export ANSIBLE_VERBOSE="-vvv"
        make run

* Executing tests on your local macOS machine. In System Preferences -> Sharing
  enable _Remote Login_ (SSH). Don't forget to disable _Remote Login_ when you
  are done.

        export ANSIBLE_EXTRA_FLAGS="--ask-sudo-pass"
        export ANSIBLE_LIMIT="localhost"
        make run

* To run just the APM Server tests, set `ANSIBLE_EXTRA_FLAGS="--tags apm-server"` in
  the environment.

## Cleanup

You need to tear down the VMs when you are finished.

    make clean
