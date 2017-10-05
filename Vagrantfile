#

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
  end
  config.vm.network "forwarded_port", guest: 4444, host: 4444


  config.vm.provision "shell", inline: <<~EOF
    apt-get update
    apt-get install -y \
      virtualbox-guest-dkms \
      virtualbox-guest-utils \
      virtualbox-guest-x11 \
      xorg \
      openbox \
      build-essential \
      git \
      liblua5.1-dev \
      libevent-dev \
      libglfw3-dev \
      libglew1.5-dev \
      libftgl-dev \
      libavcodec-dev \
      libswscale-dev \
      libavformat-dev \
      libdevil-dev \
      libxinerama-dev \
      libxcursor-dev \
      libxrandr-dev \
      libxi-dev \
      lua5.1
    mkdir -p src
    cd src
    git clone https://github.com/dividuum/info-beamer.git
    cd info-beamer
    make
    make install
    cat >/root/.xinitrc <<SEOF
  xrandr --output VGA-0 --mode 1920x1080
  sleep 2
  info-beamer /vagrant/root-node
  SEOF
    pkill Xorg
    startx &
  EOF

end
