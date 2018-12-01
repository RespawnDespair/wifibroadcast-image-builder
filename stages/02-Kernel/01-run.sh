# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

log "Patch the Kernel"
pushd linux

for PATCH_FILE in "${STAGE_DIR}/PATCHES/"*; do
    log "Applying patch ${PATCH_FILE}"
    patch -N -p0 < $PATCH_FILE
done

# out of linux 
popd

#return 
popd
