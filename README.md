# The Beats Tester

Vagrant + Ansible setup for testing the OS packages and basic e2e tests for all
the [Beats](https://www.elastic.co/products/beats).


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

* Only a particular OS, Debian 6 amd64 in the example:

        # Instead using 'make setup' launch vagrant machines manually.
        vagrant up tester-debian6-64
        vagrant ssh-config > ssh_config
        export ANSIBLE_LIMIT="tester-debian9-64"
        make run

* Enable Ansible debug.

        export ANSIBLE_VERBOSE="-vvv"
        make run

## Cleanup

You need to tear down the VMs when you are finished.

    make clean
