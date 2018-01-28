# Defines LAB08 Vagrant environment
#
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

	config.ssh.insert_key = true
	config.vbguest.auto_update = true

      # create Google Cloud Platform Management (gcpmgmt) node
	config.vm.define :gcpmgmt do |gcpmgmt_config|
	gcpmgmt_config.vm.box = "boxcutter/ubuntu1604"
	gcpmgmt_config.vm.hostname = "gcpmgmt"
	gcpmgmt_config.vm.network :private_network, ip: "192.168.56.56"
	gcpmgmt_config.vm.provider "virtualbox" do |vb|
      	vb.name = "gcpmgmt"
      	opts = ["modifyvm", :id, "--natdnshostresolver1", "on"]
      	vb.customize opts
      	vb.memory = "1024"
      end
      gcpmgmt_config.vm.provision :shell, path: "bootstrap-gcp-mgmt.sh"
	end

end
