# The Beats Tester

Vagrant + Ansible setup for testing the OS packages and basic e2e tests for all
the [Beats](https://www.elastic.co/products/beats)


## Execute

First, you need to bring the machines up:

    vagrant up

and make them known by name to SSH:

    vagrant ssh-config >> ~/.ssh/config

Then you can use Ansible to run the tests. Because they involve lots of VMs and
commands executed over SSH, these tests are slow (currently 15 minutes in
total). However, while creating tests or checking something quickly, you can
use different Ansible commands to execute only a subset.

Here are some execution examples:

* Test the most recent nightly builds (excluding OS X):

        make nightlies

* All tests, all platforms, a particular release:

        ansible-playbook -i hosts -e @run-settings-1.0.0-beta3.yml site.yml

* Only a particular Beat, Packetbeat in the example:

        ansible-playbook -i hosts -e @run-settings-nightly.yml --tags packetbeat site.yml

* Only a particular OS, Debian 6 amd64 in the example:

        ansible-playbook -i hosts -e @run-settings-nightly.yml --limit tester-debian6-64 site.yml

* On macOS X, Note that you need to enable remote SSH login.

        ansible-playbook -i hosts -e @run-settings-staging.yml --limit darwin site.yml --ask-sudo-pass

## Requirements

* Ansible = 2.3.1
* pywinrm >= 0.2.2"
