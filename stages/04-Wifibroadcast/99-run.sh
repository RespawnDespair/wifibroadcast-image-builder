# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

MNT_DIR="${STAGE_WORK_DIR}/mnt"
sudo cp "$MNT_DIR/root/ld.so.preload" "$MNT_DIR/etc/ld.so.preload"

#return
popd
