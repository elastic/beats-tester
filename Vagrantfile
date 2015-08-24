# -*- mode: ruby -*-
# vi: set ft=ruby :

# This Vagrantfile is for testing the setup locally.

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # Use a debian squeeze base machine
    config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-73-x64-virtualbox-nocm.box"

    config.vm.define "tester-centos6-32" do |testvm|
        testvm.vm.box = "centos32"
        testvm.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-i386-virtualbox-puppet.box"

        testvm.ssh.port = 2401
        testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port
        testvm.vm.network "private_network", ip: "192.168.33.70"
    end

    config.vm.define "tester-centos6-64" do |testvm|
        testvm.vm.box = "centos64"
        testvm.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"

        testvm.ssh.port = 2402
        testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port
        testvm.vm.network "private_network", ip: "192.168.33.71"
    end

    config.vm.define "tester-debian6-32" do |testvm|
        testvm.vm.box = "debian6_32"
        testvm.vm.box_url = "http://dl.dropbox.com/u/40989391/vagrant-boxes/debian-squeeze-i386.box"

        testvm.ssh.port = 2403
        testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port
        testvm.vm.network "private_network", ip: "192.168.33.72"
    end

    config.vm.define "tester-debian6-64" do |testvm|
        testvm.vm.box = "debian64"
        testvm.vm.box_url = "http://public.sphax3d.org/vagrant/squeeze64.box"

        testvm.ssh.port = 2404
        testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port
        testvm.vm.network "private_network", ip: "192.168.33.73"
    end
end
