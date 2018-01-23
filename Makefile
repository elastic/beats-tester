RUN_SETTINGS?=staging
# Control ansible's verbosity by setting this with -v or -vvvvv (more verbose).
ANSIBLE_VERBOSE?=
# Exluding localhost, as localhost is assumed to be Mac OS X with ssh enabled.
ANSIBLE_LIMIT?=all:!localhost
# Extra flags to pass to Ansible (e.g. --skip-tags filebeat).
ANSIBLE_EXTRA_FLAGS?=

# TODO (2018-01-22 andrewkroh): Remove this after Filebeat is fixed.
# https://github.com/elastic/beats/issues/6145
ANSIBLE_EXTRA_FLAGS=--skip-tags filebeat

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

# Run Ansible from the virtualenv.
run: ve
	ve/bin/ansible-playbook \
	${ANSIBLE_VERBOSE} \
	-i hosts \
	--ssh-extra-args '-F ssh_config' \
	-e @run-settings-${RUN_SETTINGS}.yml \
	--limit "${ANSIBLE_LIMIT}" \
	${ANSIBLE_EXTRA_FLAGS} \
	site.yml

# This destroys all vagrant machines and removes the vagrant related data
clean:
	-vagrant destroy -f
	-rm -r .vagrant
