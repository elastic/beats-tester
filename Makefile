
setup:
	vagrant up
	vagrant ssh-config >> ~/.ssh/config

# Run build based on RUN_SETTINGS name
run: setup
	# Exluding localhost, as localhost is assumed to be Mac OS X with ssh enabled
	ansible-playbook -i hosts -e @run-settings-${RUN_SETTINGS}.yml --limit 'all:!localhost' site.yml
	
1.1.0:
	RUN_SETTINGS=1.1.0-latest make run
	
1.2.0:
	RUN_SETTINGS=1.2.0-latest make run

# This destroys all vagrant machines and removes the vagrant related data
clean:
	-vagrant destroy -f
	-rm -r .vagrant
