RUN_SETTINGS?=nightlies
# Control ansible's verbosity by setting this with -v or -vvvvv (more verbose).
ANSIBLE_VERBOSE?=
# Exluding localhost, as localhost is assumed to be Mac OS X with ssh enabled.
ANSIBLE_LIMIT?=all:!localhost
# Extra flags to pass to Ansible (e.g. --skip-tags filebeat).
ANSIBLE_EXTRA_FLAGS?=
GROUPS?=centos debian sles windows

# Create a virtualenv to run Ansible.
ve: ve/bin/activate
ve/bin/activate: requirements.txt
	@test -d ve || virtualenv ve
	@ve/bin/pip install -Ur requirements.txt
	@touch ve/bin/activate

# Setup the VMs and the SSH config needed for Ansible to communicate to them.
setup:
	vagrant up
	vagrant ssh-config > ssh_config

batch:
	$(foreach GROUP,${GROUPS},GROUP=${GROUP} ${MAKE} run-group || exit 1;)

run-group: HOSTS=$(shell ansible ${GROUP} -i hosts --list-hosts | tail -n +2)
run-group:
	vagrant up ${HOSTS}
	vagrant status ${HOSTS}
	vagrant ssh-config ${HOSTS} >ssh_config
	ANSIBLE_LIMIT=${GROUP} make run
	vagrant destroy -f ${HOSTS}

# XXX (andrewkroh on 2018-02-07): OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES is
# added as a workaround to a MacOS 10.13 (High Sierra) issue with python and
# Ansible. See https://github.com/ansible/ansible/issues/32499.
# Run Ansible from the virtualenv.
ansible-playbook-run-%: ve
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES \
	ve/bin/ansible-playbook \
	${ANSIBLE_VERBOSE} \
	-i hosts \
	--ssh-extra-args '-F ssh_config' \
	-e @run-settings-${RUN_SETTINGS}.yml \
	--limit "${ANSIBLE_LIMIT}" \
	${ANSIBLE_EXTRA_FLAGS} \
	$*.yml

run-elastic: ansible-playbook-run-elastic

run-oss: ansible-playbook-run-oss

run: run-elastic run-oss

# This destroys all vagrant machines and removes the vagrant related data
clean:
	-vagrant destroy -f
	-rm -r .vagrant

.PHONY: batch clean run run-elastic run-group run-oss setup ve
