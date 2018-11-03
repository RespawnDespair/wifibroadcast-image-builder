# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

log "Remove previous Kernel"
rm -r linux

log "Download the Raspberry Pi Kernel"
"git clone --depth=1 https://github.com/raspberrypi/linux
git clone --depth=100 https://github.com/raspberrypi/linux/
cd linux/
git checkout c5f7d3c4daf14ba3717fcc1497854d8c365bd742
cd ..

log "Download the rtl8812au drivers"
# Fixed at v5.2.20 as it is deemed more stable for now
git clone -b v5.2.20 https://github.com/aircrack-ng/rtl8812au.git

#return 
popd
