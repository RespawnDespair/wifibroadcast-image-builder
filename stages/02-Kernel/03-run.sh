# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

log "Compile kernel For Pi 2, Pi 3, Pi 3+, or Compute Module 3"
pushd linux

KERNEL=kernel7 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make bcm2709_defconfig
KERNEL=kernel7 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j4 zImage modules dtbs

log "Saving kernel as ${STAGE_WORK_DIR}/kernel7.img"
mv arch/arm/boot/zImage "${STAGE_WORK_DIR}/kernel7.img"

# out of linux 
popd

#return 
popd