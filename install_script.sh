#!/bin/bash

set -e

# Latest package source
sudo rm -rf /var/lib/apt/lists/*
sudo apt-get clean
sudo apt-get update

# Remove all X related (2,3 Gb of Disk space freed...) 
# Should be fixed with lite image
#sudo apt-get -y remove --auto-remove --purge libx11-.*

# Install essentials
export DEBIAN_FRONTEND=noninteractive
#untill we find a way for noniteractive
sudo apt-get -y install python-pip
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq install aircrack-ng
sudo apt-get -y install gnuplot
sudo apt-get -y install udhcpd
sudo apt-get -y install socat
DEBIAN_FRONTEND=noninteractive sudo apt-get -y install tshark
sudo apt-get -y install ser2net
sudo apt-get -y install gstreamer1.0-tools
sudo apt-get -y install libtool
sudo apt-get -y install autoconf
sudo apt-get -y install libsdl1.2-dev
sudo apt-get -y install libboost-all-dev cmake libconfig++-dev libreadline-dev
sudo apt-get -y install git libpcap-dev wiringpi iw usbmount
sudo apt-get -y install libjpeg8-dev indent libfreetype6-dev ttf-dejavu-core
sudo apt-get -y install tofrodos
sudo ln -s /usr/bin/fromdos /usr/bin/dos2unix

# Python essentials for mavlink router autoconf
#sudo easy_install pip
sudo pip install future

# Git:// uri does not always work
sudo git config --global url."http://github.com/".insteadOf git@github.com:
sudo git config --global url."http://".insteadOf git://

# Install OpenVG
cd /home/pi
sudo git clone --verbose https://github.com/ajstarks/openvg.git
cd openvg
sudo make clean
sudo make library
sudo make install

# Gets stuck
# Install mavlink-router
cd /home/pi
sudo git clone --progress https://github.com/intel/mavlink-router.git 
cd mavlink-router
sudo git submodule update --init --recursive --progress
sudo ./autogen.sh && sudo ./configure CFLAGS='-g -O2' \
        --sysconfdir=/etc --localstatedir=/var --libdir=/usr/lib64 \
    --prefix=/usr
sudo make

# Install cmavnode
cd /home/pi
sudo git clone https://github.com/MonashUAS/cmavnode.git
cd cmavnode
sudo git submodule update --init
sudo mkdir build && cd build
sudo cmake ..
sudo make
sudo make install

# install wifibroadcast base
cd /home/pi
sudo git clone https://github.com/RespawnDespair/wifibroadcast-base.git
cd wifibroadcast-base
sudo git submodule init
sudo git submodule update
sudo make clean
sudo make

#install wifibroadcast-osd
cd /home/pi
sudo git clone https://github.com/RespawnDespair/wifibroadcast-osd.git
cd wifibroadcast-osd
sudo git submodule init
sudo git submodule update
sudo make clean
sudo make

#install wifibroadcast-rc
cd /home/pi
sudo git clone https://github.com/RespawnDespair/wifibroadcast-rc.git
cd wifibroadcast-rc
sudo chmod +x build.sh
sudo ./build.sh

#install wifibroadcast-scripts
cd /home/pi
sudo git clone https://github.com/RespawnDespair/wifibroadcast-scripts.git
cd wifibroadcast-scripts
# Copy to root so it runs on startup
sudo cp .profile /root/

#install wifibroadcast-misc
cd /home/pi
sudo git clone https://github.com/RespawnDespair/wifibroadcast-misc.git


#patch hello_video
cd /home/pi
git clone https://github.com/RespawnDespair/wifibroadcast-hello_video.git
sudo cp wifibroadcast-hello_video/* /opt/vc/src/hello_pi/hello_video/
# REBUILDING DOES NOT WORK, BINARIES INCLUDED IN GIT
#cd /opt/vc/src/hello_pi/
#sudo ./rebuild.sh


#install new firmware
#sudo cp "patches/AR9271/firmware/htc_9271.fw" "/lib/firmware"

# Make fifos
sudo mkfifo /root/videofifo1
sudo mkfifo /root/videofifo2
sudo mkfifo /root/videofifo3
sudo mkfifo /root/videofifo4
sudo mkfifo /root/telemetryfifo1
sudo mkfifo /root/telemetryfifo2
sudo mkfifo /root/telemetryfifo3
sudo mkfifo /root/telemetryfifo4
sudo mkfifo /root/telemetryfifo5
sudo mkfifo /root/telemetryfifo6
sudo mkfifo /root/mspfifo

# Copy tty autologin stuff
cd /etc/systemd/system/getty.target.wants
sudo cp getty@tty1.service getty@tty2.service
sudo cp getty@tty1.service getty@tty3.service
sudo cp getty@tty1.service getty@tty4.service
sudo cp getty@tty1.service getty@tty5.service
sudo cp getty@tty1.service getty@tty6.service
sudo cp getty@tty1.service getty@tty7.service
sudo cp getty@tty1.service getty@tty8.service
sudo cp getty@tty1.service getty@tty9.service
sudo cp getty@tty1.service getty@tty10.service
sudo cp getty@tty1.service getty@tty11.service
sudo cp getty@tty1.service getty@tty12.service

#enable /dev/video0
#sudo modprobe bcm2835-v4l2

#disable sync option for usbmount
sudo sed -i 's/sync,//g' /etc/usbmount/usbmount.conf

#change hostname
CURRENT_HOSTNAME=`sudo cat /etc/hostname | sudo tr -d " \t\n\r"`
NEW_HOSTNAME="wbc"
if [ $? -eq 0 ]; then
  sudo sh -c "echo '$NEW_HOSTNAME' > /etc/hostname"
  sudo sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts
fi



