# -*- mode: ruby -*-
# vi: set ft=ruby :

# This Vagrantfile is for testing the setup locally.

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.define "tester-centos6-32" do |testvm|
        testvm.vm.box = "centos32"
        testvm.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-i386-virtualbox-puppet.box"

        testvm.ssh.port = 2401
        # workaround for vagrant 1.8.5 bug: https://github.com/mitchellh/vagrant/issues/7610
        testvm.ssh.insert_key = false
        testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port
        testvm.vm.network "private_network", ip: "192.168.33.70"
    end

    config.vm.define "tester-centos6-64" do |testvm|
        testvm.vm.box = "centos64"
        testvm.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"

        testvm.ssh.port = 2402
        # workaround for vagrant 1.8.5 bug: https://github.com/mitchellh/vagrant/issues/7610
        testvm.ssh.insert_key = false
        testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port
        testvm.vm.network "private_network", ip: "192.168.33.71"
    end

    config.vm.define "tester-ubuntu1204-32" do |testvm|
        testvm.vm.box = "hashicorp/precise32"

        testvm.ssh.port = 2403
        testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port
        # workaround for vagrant 1.8.5 bug
        config.vm.network "private_network", ip: "192.168.33.72", type: "dhcp", auto_config: false
    end

    config.vm.define "tester-debian6-64" do |testvm|
        testvm.vm.box = "debian64"
        testvm.vm.box_url = "http://public.sphax3d.org/vagrant/squeeze64.box"

        testvm.ssh.port = 2404
        testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port
        testvm.vm.network "private_network", ip: "192.168.33.73"
    end

    config.vm.define "tester-centos7-64" do |testvm|
        testvm.vm.box = "relativkreativ/centos-7-minimal"

        testvm.ssh.port = 2405
        # workaround for vagrant 1.8.5 bug: https://github.com/mitchellh/vagrant/issues/7610
        testvm.ssh.insert_key = false
        testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port
        testvm.vm.network "private_network", ip: "192.168.33.74"
    end

    config.vm.define "tester-win12-64" do |testvm|
	testvm.vm.box = "https://s3.amazonaws.com/beats-files/vagrant/beats-win2012-r2-virtualbox-2015-12-10_1222.box"

	testvm.ssh.port = 2406
	testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port
	testvm.vm.network "private_network", ip: "192.168.33.75"

	testvm.vm.communicator = "winrm"
	testvm.vm.network "forwarded_port", host: 3389, guest: 3389
	testvm.vm.network "forwarded_port", host: 5985, guest: 5985

	testvm.vm.provider "virtualbox" do |v|
	    v.gui = false
	    v.cpus = 2
	    v.memory = 2048
	end
    end
end
