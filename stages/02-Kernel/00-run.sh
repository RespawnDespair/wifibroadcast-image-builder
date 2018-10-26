# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

log "Remove previous Kernel"
rm -r linux

log "Download the Raspberry Pi Kernel"
git clone --depth=1 https://github.com/raspberrypi/linux

#return 
popd