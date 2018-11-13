# This runs in context if the image (CHROOT)
# Any native compilation can be done here
# Do not use log here, it will end up in the image

#!/bin/bash

# disable dhcpcd service
sudo systemctl stop dhcpcd.service
sudo systemctl disable dhcpcd.service

# Latest package source
sudo rm -rf /var/lib/apt/lists/*
sudo apt-get clean
sudo apt-get update

# Install essentials
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install python-pip
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install aircrack-ng
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install gnuplot
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install udhcpd
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install socat
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install tshark
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install ser2net
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install gstreamer1.0-tools
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install gstreamer1.0-plugins-bad
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install gstreamer1.0-plugins-good
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install libtool
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install autoconf
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install libsdl1.2-dev
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install libboost-all-dev cmake libconfig++-dev libreadline-dev
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install git libpcap-dev wiringpi iw usbmount
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install libjpeg8-dev indent libfreetype6-dev ttf-dejavu-core
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install python-m2crypto
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install dos2unix
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install hostapd
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install pump
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install libpng12-dev
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install python-future python-attr
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install libfontconfig1-dev 
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install libsdl2-dev
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install libsdl1.2-dev

# Remove packages that conflict with the workings of EZ-Wifibroadcast
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq purge wireless-regdb
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq purge wpasupplicant

# Python essentials for mavlink router autoconf
sudo pip install future

