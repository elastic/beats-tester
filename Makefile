
setup:
	vagrant up
	vagrant ssh-config >> ~/.ssh/config

nightlies: setup
	# Exluding localhost, as localhost is assumed to be Mac OS X with ssh enabled
	ansible-playbook -i hosts -e @run-settings-nightly.yml --limit 'all:!localhost' site.yml

beta4: setup
	ansible-playbook -i hosts -e @run-settings-1.0.0-beta4.yml --limit 'all:!localhost' site.yml
