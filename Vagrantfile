# -*- mode: ruby -*-
# vim: set et sw=2 ft=ruby:

# This Vagrantfile is for testing the setup locally.

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "tester-centos6-32" do |testvm|
    testvm.vm.box = "centos32"
    testvm.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-i386-virtualbox-puppet.box"

    testvm.ssh.port = 2401
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.70"
    testvm.vm.provision "shell", inline: "rm /etc/yum.repos.d/puppetlabs*.repo"
  end

  config.vm.define "tester-centos6-64" do |testvm|
    testvm.vm.box = "centos64"
    testvm.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"

    testvm.ssh.port = 2402
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.71"
  end

  config.vm.define "tester-ubuntu1204-32" do |testvm|
    testvm.vm.box = "ubuntu/precise32"

    testvm.ssh.port = 2403
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.72"
  end


  config.vm.define "tester-debian8-64" do |testvm|
    config.vm.box = "debian/jessie64"

    testvm.ssh.port = 2404
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.73"
  end

  config.vm.define "tester-centos7-64" do |testvm|
    testvm.vm.box = "relativkreativ/centos-7-minimal"

    testvm.ssh.port = 2405
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.74"
  end

  config.vm.define "tester-win12-64" do |testvm|
    testvm.vm.box = "https://s3.amazonaws.com/beats-files/vagrant/beats-win2012-r2-virtualbox-2015-12-10_1222.box"

    testvm.ssh.port = 2406
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.75"

    testvm.vm.communicator = "winrm"
    testvm.vm.network "forwarded_port", host: 3389, guest: 3389, host_ip: "127.0.0.1"
    testvm.vm.network "forwarded_port", host: 5985, guest: 5985, host_ip: "127.0.0.1"

    testvm.vm.provider "virtualbox" do |v|
      v.gui = false
      v.cpus = 2
      v.memory = 2048
    end
  end

  config.vm.define "tester-ubuntu1604-64" do |testvm|
    testvm.vm.box = "ubuntu/xenial64"

    testvm.ssh.port = 2407
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.76"
    testvm.vm.provision "python", type: "shell", inline: ubuntu_provision_python()
  end

  config.vm.define "tester-opensuse42-64" do |testvm|
    testvm.vm.box = "bento/opensuse-leap-42.2"

    testvm.ssh.port = 2408
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.77"
  end

  config.vm.define "tester-awslinux" do |testvm|
    testvm.vm.box = "mvbcoding/awslinux"

    testvm.ssh.port = 2409
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.78"
  end

  config.vm.define "tester-debian9-64" do |testvm|
    testvm.vm.box = "debian/stretch64"

    testvm.ssh.port = 2410
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.79"
    testvm.vm.provision "python", type: "shell", inline: ubuntu_provision_python()
  end

  config.vm.define "tester-sles12-64" do |testvm|
    testvm.vm.box = "elastic/sles-12-x86_64"

    testvm.ssh.port = 2411
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.80"
  end

  config.vm.define "tester-ubuntu1404-64" do |testvm|
    testvm.vm.box = "ubuntu/trusty64"

    testvm.ssh.port = 2412
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.81"
    testvm.vm.provision "python", type: "shell", inline: ubuntu_provision_python()
  end

  config.vm.define "tester-ubuntu1804-64" do |testvm|
    testvm.vm.box = "ubuntu/bionic64"

    testvm.ssh.port = 2413
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.82"
    testvm.vm.provision "python", type: "shell", inline: ubuntu_provision_python()
  end

  config.vm.define "tester-amzn2" do |testvm|
    testvm.vm.box = "gbailey/amzn2"

    testvm.ssh.port = 2414
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.83"
  end

end

def ubuntu_provision_python()
  return <<-SHELL
  set -e
  apt-get update
  apt-get install -y python-minimal python2.7
  SHELL
end
