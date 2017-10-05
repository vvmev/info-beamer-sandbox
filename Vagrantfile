#

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
    # enable HiDPI mode
    vb.customize ["setextradata", :id, "GUI/HiDPI/UnscaledOutput", "1"]
  end
  config.vm.network "forwarded_port", guest: 4444, host: 4444

  config.vm.provision "shell", path: 'provision.sh'

end
