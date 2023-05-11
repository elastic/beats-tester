# -*- mode: ruby -*-
# vim: set et sw=2 ft=ruby:

# This Vagrantfile is for testing the setup locally.

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "tester-debian8-64" do |testvm|
    config.vm.box = "debian/jessie64"

    testvm.ssh.port = 2404
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.73"
    testvm.vm.provider "virtualbox" do |v|
      v.destroy_unused_network_interfaces = true
    end
  end

  config.vm.define "tester-centos7-64" do |testvm|
    testvm.vm.box = "relativkreativ/centos-7-minimal"

    testvm.ssh.port = 2405
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.74"
    testvm.vm.provider "virtualbox" do |v|
      v.destroy_unused_network_interfaces = true
    end
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
      v.destroy_unused_network_interfaces = true
    end
  end

  config.vm.define "tester-awslinux" do |testvm|
    testvm.vm.box = "mvbcoding/awslinux"

    testvm.ssh.port = 2409
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.78"
    testvm.vm.provider "virtualbox" do |v|
      v.destroy_unused_network_interfaces = true
    end
  end

  config.vm.define "tester-debian9-64" do |testvm|
    testvm.vm.box = "generic/debian9"

    testvm.ssh.port = 2410
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.79"
    testvm.vm.provision "fix9", type: "shell", inline: fix_debian_9()
    testvm.vm.provision "python", type: "shell", inline: ubuntu_provision_python()
    testvm.vm.provider "virtualbox" do |v|
      v.destroy_unused_network_interfaces = true
    end
  end

  config.vm.define "tester-sles12-64" do |testvm|
    testvm.vm.box = "elastic/sles-12-x86_64"

    testvm.ssh.port = 2411
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.80"
    testvm.vm.provider "virtualbox" do |v|
      v.destroy_unused_network_interfaces = true
    end
  end

  config.vm.define "tester-ubuntu1804-64" do |testvm|
    testvm.vm.box = "ubuntu/bionic64"

    testvm.ssh.port = 2413
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.82"
    testvm.vm.provision "python", type: "shell", inline: ubuntu_provision_python()
    testvm.vm.provider "virtualbox" do |v|
      v.destroy_unused_network_interfaces = true
    end
  end

  config.vm.define "tester-awslinux2" do |testvm|
    testvm.vm.box = "gbailey/amzn2"

    testvm.ssh.port = 2414
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.83"
    testvm.vm.provider "virtualbox" do |v|
      v.destroy_unused_network_interfaces = true
    end
  end

  config.vm.define "tester-centos8-64" do |testvm|
    testvm.vm.box = "generic/centos8"

    testvm.ssh.port = 2415
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.84"
    testvm.vm.provider "virtualbox" do |v|
      v.destroy_unused_network_interfaces = true
    end
  end

  config.vm.define "tester-win19-64" do |testvm|
    testvm.vm.box = "mikemadden42/windows_2019"

    testvm.ssh.port = 2417
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.86"

    testvm.vm.communicator = "winrm"
    testvm.vm.network "forwarded_port", host: 3390, guest: 3389, host_ip: "127.0.0.1"
    testvm.vm.network "forwarded_port", host: 5986, guest: 5985, host_ip: "127.0.0.1"

    testvm.vm.provider "virtualbox" do |v|
      v.gui = false
      v.cpus = 2
      v.memory = 2048
      v.destroy_unused_network_interfaces = true
    end
  end

  config.vm.define "tester-debian10-64" do |testvm|
    testvm.vm.box = "generic/debian10"

    testvm.ssh.port = 2418
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.87"
    testvm.vm.provision "python", type: "shell", inline: ubuntu_provision_python()
    testvm.vm.provider "virtualbox" do |v|
      v.destroy_unused_network_interfaces = true
    end
  end

  config.vm.define "tester-ubuntu2004-64" do |testvm|
    testvm.vm.box = "ubuntu/focal64"

    testvm.ssh.port = 2419
    testvm.vm.network "forwarded_port", guest: 22, host: testvm.ssh.port, host_ip: "127.0.0.1"
    testvm.vm.network "private_network", ip: "192.168.33.88"
    testvm.vm.provision "python", type: "shell", inline: ubuntu_provision_python()
    testvm.vm.synced_folder ".", "/vagrant", disabled: true
    testvm.vm.provider "virtualbox" do |v|
      v.destroy_unused_network_interfaces = true
    end
  end

end

def ubuntu_provision_python()
  return <<-SHELL
  set -e
  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y aptitude python-apt python2.7
  SHELL
end

def fix_debian_9()
  return <<-SHELL
  set -e
  sed -i s/deb.debian.org/archive.debian.org/g /etc/apt/sources.list \
    && sed -i 's|security.debian.org|archive.debian.org/|g' /etc/apt/sources.list \
    && sed -i '/stretch-updates/d' /etc/apt/sources.list 
  SHELL
end
