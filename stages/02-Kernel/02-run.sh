# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

log "Compile kernel For Pi 1, Pi Zero, Pi Zero W, or Compute Module"
pushd linux

KERNEL=kernel ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make bcmrpi_defconfig
KERNEL=kernel ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j4 zImage modules dtbs

log "Saving kernel as ${STAGE_WORK_DIR}/kernel1.img"
mv arch/arm/boot/zImage "${STAGE_WORK_DIR}/kernel1.img"

# out of linux 
popd

#return 
popd