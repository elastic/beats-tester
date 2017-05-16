ve: ve/bin/activate
ve/bin/activate: requirements.txt
	@test -d ve || virtualenv ve
	@ve/bin/pip install -Ur requirements.txt
	@touch ve/bin/activate

setup:
	vagrant up
	vagrant ssh-config >> ~/.ssh/config

run: ve
	@if test -z "$$RUN_SETTINGS"; then echo "RUN_SETTINGS is not set. For example, try using RUN_SETTINGS=staging."; exit 1; fi
	ve/bin/ansible-playbook -vvvv -i hosts -e @run-settings-${RUN_SETTINGS}.yml --limit 'all:!localhost' site.yml
	
# This destroys all vagrant machines and removes the vagrant related data.
clean:
	-vagrant destroy -f
	-rm -r .vagrant
