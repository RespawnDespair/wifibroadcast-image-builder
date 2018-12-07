#!/bin/bash


echo "
# Install OpenVG and flir stuff
cd /home/pi
sudo mkdir /home/pi/flir
sudo mv v4l2loopback /home/pi/flir

echo 'VER ${KERNEL_VERSION}'

cd flir
cd v4l2loopback
sudo make KERNELRELEASE=$KERNEL_VERSION
sudo make KERNELRELEASE=$KERNEL_VERSION install

# COMMENTED OUT AS IT IS CAUSING FATAL ERROR DUE TO WRONG VERSION (uname issue)
sudo depmod -a -w $KERNEL_VERSION

cd /home/pi/flir
sudo git clone https://github.com/fnoop/flirone-v4l2.git
cd flirone-v4l2
sudo make
" > tmpfile

on_chroot < tmpfile
