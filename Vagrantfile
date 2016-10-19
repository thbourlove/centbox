# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  # config.vm.box_check_update = false

  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = "4"
    vb.memory = "1024"
    vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000 ]
  end

  config.vm.provision "file", source: "configurations", destination: "/tmp/configurations"
  config.vm.provision "shell", path: "init.sh"

end
