# This runs in context if the image (CHROOT)
# Any native compilation can be done here
# Do not use log here, it will end up in the image

#!/bin/bash

# Install OpenVG
cd /home/pi
cd openvg
sudo make clean
sudo make -j $J_CORES library
sudo make -j $J_CORES install

# Gets stuck
# Install mavlink-router
cd /home/pi
cd mavlink-router
sudo ./autogen.sh && sudo ./configure CFLAGS='-g -O2' \
        --sysconfdir=/etc --localstatedir=/var --libdir=/usr/lib64 \
    --prefix=/usr
sudo make -j $J_CORES 

# Install cmavnode
cd /home/pi
cd cmavnode
sudo mkdir build && cd build
sudo cmake ..
sudo make -j $J_CORES 
sudo make -j $J_CORES install

# install wifibroadcast base
cd /home/pi
cd wifibroadcast-base
sudo make clean
sudo make -j $J_CORES 

#install wifibroadcast-rc
cd /home/pi
cd wifibroadcast-rc
sudo chmod +x build.sh

#install wifibroadcast-status
cd /home/pi
cd wifibroadcast-status
sudo make clean
sudo make -j $J_CORES 

#install wifibroadcast-scripts
cd /home/pi
cd wifibroadcast-scripts
# Copy to root so it runs on startup
sudo cp .profile /root/

#install wifibroadcast-misc
cd /home/pi
cd wifibroadcast-misc
sudo chmod +x ftee
sudo chmod +x raspi2png

#install wifibroadcast-splash
cd /home/pi
cd wifibroadcast-splash
sudo make -j $J_CORES 

#patch hello_video
cd /home/pi
sudo cp wifibroadcast-hello_video/* /opt/vc/src/hello_pi/hello_video/
# REBUILDING DOES NOT WORK, BINARIES INCLUDED IN GIT
cd /opt/vc/src/hello_pi/hello_video
sudo rm hello_video.bin.48-mm 2> /dev/null || echo > /dev/null
sudo rm hello_video.bin.30-mm 2> /dev/null || echo > /dev/null
sudo rm hello_video.bin.240-befi 2> /dev/null || echo > /dev/null

sudo cp video.c.48-mm video.c
cd ..
sudo make -j $J_CORES 
cd /opt/vc/src/hello_pi/hello_video
mv hello_video.bin hello_video.bin.48-mm

sudo cp video.c.30-mm video.c
cd ..
sudo make -j $J_CORES 
cd /opt/vc/src/hello_pi/hello_video
mv hello_video.bin hello_video.bin.30-mm

sudo cp video.c.240-befi video.c
cd ..
sudo make -j $J_CORES 
cd /opt/vc/src/hello_pi/hello_video
mv hello_video.bin hello_video.bin.240-befi


