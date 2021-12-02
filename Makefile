## @variable:RUN_SETTINGS:Profile to be passed as Ansible settings. Default is 'nightlies'
RUN_SETTINGS?=nightlies
## @variable:ANSIBLE_VERBOSE:Control ansible's verbosity by setting this with -v or -vvvvv (more verbose). Default is empty
ANSIBLE_VERBOSE?=
## @variable:ANSIBLE_LIMIT:Excluding localhost, as localhost is assumed to be Mac OS X with ssh enabled. Default is 'all:!localhost'
ANSIBLE_LIMIT?=all:!localhost
## @variable:ANSIBLE_EXTRA_FLAGS:Extra flags to pass to Ansible (e.g. --skip-tags filebeat). Default is empty
ANSIBLE_EXTRA_FLAGS?=
## @variable:GROUPS:Ansible host groups declared in the hosts file. Default is 'debian sles windows centos' (centos is not in alphabetic order.  It was moved to the end of the list since periodic failures were preventing the other groups from running)
GROUPS?=debian sles windows centos
## @variable:MACHINE:Name of the Vagrant machine to be used in tests. Default is empty.
MACHINE?=

## @help:ve/bin/activate:Create a virtualenv to run Ansible.
ve: ve/bin/activate
## @help:ve:Activate Python's virtual environment
ve/bin/activate: requirements.txt
	@test -d ve || virtualenv ve
	@ve/bin/pip install -Ur requirements.txt
	@touch ve/bin/activate

## @help:setup:Setup the VMs and the SSH config needed for Ansible to communicate to them.
setup:
	vagrant up $(MACHINE)
	vagrant ssh-config $(MACHINE) > ssh_config

## @help:batch:Run the tests for each ansible group (GROUPS) in batches. Since it processes each group sequentially, it uses less CPU and memory.
batch:
	$(foreach GROUP,${GROUPS},GROUP=${GROUP} ${MAKE} run-group || exit 1;)

## @help:run-group:Run the tests for all the OSs in a group of OSs. For each ansible group, it will start the vm, check the VM's status, configure SSH, run the ansible playbook, and finally will destroy the vm.
# Find the hosts that belong to a given ansible group.
run-group: HOSTS=$(shell ansible ${GROUP} -i hosts --list-hosts | tail -n +2)
run-group: ve
	vagrant up $(HOSTS)
	vagrant status $(HOSTS)
	vagrant ssh-config $(HOSTS) >ssh_config
	ANSIBLE_LIMIT=$(GROUP) make run
	vagrant destroy -f $(HOSTS)

## @help:run-machine:Run the tests for a single machine. Needs MACHINE environment variable to be set.
run-machine: ve
	vagrant up $(MACHINE)
	vagrant status $(MACHINE)
	vagrant ssh-config $(MACHINE) > ssh_config
	ANSIBLE_LIMIT=$(MACHINE) make run
	vagrant destroy -f $(MACHINE)

## @help:ci:Use this target for continuous integration tools like Jenkins or Travis. This should allow for maintenance without updating the CI jobs directly.
ci: batch

# XXX (andrewkroh on 2018-02-07): OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES is
# added as a workaround to a MacOS 10.13 (High Sierra) issue with python and
# Ansible. See https://github.com/ansible/ansible/issues/32499.
# Run Ansible from the virtualenv.
ansible-playbook-run-%: ve
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES \
	JUNIT_TASK_CLASS=yes \
	JUNIT_OUTPUT_DIR=logs \
	ve/bin/ansible-playbook \
	${ANSIBLE_VERBOSE} \
	-i hosts \
	--ssh-extra-args '-F ssh_config' \
	-e @run-settings-${RUN_SETTINGS}.yml \
	--limit "${ANSIBLE_LIMIT}" \
	${ANSIBLE_EXTRA_FLAGS} \
	$*.yml

## @help:run-elastic:Run the tests for Elastic packages
run-elastic: ansible-playbook-run-elastic

## @help:run-oss:Run the tests for Elastic OSS packages
run-oss: ansible-playbook-run-oss

## @help:run:Run the tests for both OSS and non-OSS Elastic packages
run: run-elastic run-oss

## @help:clean:Destroy all vagrant machines, removing the vagrant related data
clean:
	-vagrant destroy -f $(MACHINE)
	-rm -r .vagrant

## @help:markdown-matrix:Generate markdown compatibility matrix
markdown-matrix:
	@ansible -i hosts --list-hosts all | \
		sort | \
		grep -v tester-es | \
		grep -v '^#' | \
		grep tester | \
		sed 's#tester-##g' | \
		tr -d " " | \
		sed 's#\(.*\)#\1 | :white_check_mark:#g'

.PHONY: batch clean run run-elastic run-group run-oss setup ve

## @help:help:Help for beats-tester
.PHONY: help
help:
	@echo "---------------------"
	@echo "Environment variables"
	@echo "---------------------"
	@echo ""
	@grep '^## @variable' Makefile|cut -d ":" -f 2-3|( (sort|column -s ":" -t) || (sort|tr ":" "\t") || (tr ":" "\t"))
	@echo ""
	@echo "-------------"
	@echo "Main commands"
	@echo "-------------"
	@echo ""
	@grep '^## @help' Makefile|cut -d ":" -f 2-3|( (sort|column -s ":" -t) || (sort|tr ":" "\t") || (tr ":" "\t"))
	@echo ""
