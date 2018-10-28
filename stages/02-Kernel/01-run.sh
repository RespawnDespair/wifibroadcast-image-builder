# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

log "Merge the RTL8812 driver into kernel"
cp -a rtl8812au/. linux/drivers/net/wireless/realtek/rtl8812au/

log "Patch the Kernel"
pushd linux

for PATCH_FILE in "${STAGE_DIR}/PATCHES/"*; do
    log "Applying patch ${PATCH_FILE}"
    patch -N -p0 < $PATCH_FILE
done

log "Copy db.txt"
cp "${STAGE_DIR}/FILES/db.txt" ./drivers/net/wireless

# out of linux 
popd

#return 
popd
