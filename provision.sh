#!/bin/bash

if which info-beamer; then
  echo "info-beamer installed; skipping base setup"
else
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
fi

cat >/usr/share/X11/xorg.conf.d/00-defaultsize.conf <<EOF
Section "Device"
    Identifier    "Configured Video Device"
EndSection

Section "Monitor"
    Identifier    "Configured Monitor"
    HorizSync       30.0-62.0
    VertRefresh     50.0-70.0
EndSection

Section "Screen"
    Identifier    "Default Screen"
    Monitor        "Configured Monitor"
    Device        "Configured Video Device"
    DefaultDepth    24
    SubSection "Display"
        Depth    24
        Modes     "1920x1080"
    EndSubSection
EndSection
EOF

cat >/root/.xinitrc <<SEOF
sleep 2
#xrandr --output VGA-0 --mode 1920x1080
xset -dpms
xset s off
sleep 2

#export INFOBEAMER_FULLSCREEN=1
#export INFOBEAMER_FULLSCALE=1
export INFOBEAMER_WIDTH=1920
export INFOBEAMER_HEIGHT=1080
info-beamer /vagrant/root-node
SEOF

echo "### (re-)starting X11"
id
pkill Xorg
sleep 2

startx & disown
sleep 10
