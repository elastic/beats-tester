# -*- mode: ruby -*-
# vi: set ft=ruby :

# This Vagrantfile is for testing the setup locally.

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.define "tester-es" do |testvm|
        testvm.vm.box = "puphpet/debian75-x64"

        testvm.ssh.port = 2400
        testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port
        testvm.vm.network "private_network", ip: "192.168.33.60"
    end

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

    config.vm.define "tester-ubuntu1204-32" do |testvm|
        testvm.vm.box = "hashicorp/precise32"

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

    config.vm.define "tester-centos7-64" do |testvm|
        testvm.vm.box = "relativkreativ/centos-7-minimal"

        testvm.ssh.port = 2405
        testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port
        testvm.vm.network "private_network", ip: "192.168.33.74"
    end

  config.vm.define "tester-win12-64" do |testvm|
    testvm.vm.box = "http://files.ruflin.com/vagrant/windows-wincap-20151021.box"
    testvm.vm.communicator = "winrm"
    testvm.vm.network "forwarded_port", host: 3389, guest: 3389
    testvm.vm.network "forwarded_port", host: 5985, guest: 5985

    testvm.vm.provider "virtualbox" do |v|
        v.gui = true
        v.cpus = 2
        v.memory = 2048
    end
  end
end
