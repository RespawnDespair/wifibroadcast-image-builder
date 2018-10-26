# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

log "Create 2Gb empty image"
dd if=/dev/zero of=temp.img bs=1 count=1 seek=2G


log "Enlarge the downloaded image by 2Gb"
cat temp.img >> IMAGE.img

log "fdisk magic to enlarge the main partition"
fdisk IMAGE.img <<EOF
d
2
n
p
2
98304
w
EOF

# return
popd