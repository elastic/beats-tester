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

* All tests, all platforms, a particular release:

        ansible-playbook -i hosts site.yml -e @run-settings-1.0.0-beta3.yml

* Only a particular Beat, Packetbeat in the example:

        ansible-playbook -i hosts site.yml -e @run-settings-nightly.yml --tags packetbeat

* Only a particular OS, Debian 6 amd64 in the example:

        ansible-playbook -i hosts site.yml -e @run-settings-nightly.yml --limit tester-debian6-64
