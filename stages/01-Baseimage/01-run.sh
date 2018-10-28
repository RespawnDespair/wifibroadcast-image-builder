# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

log "Create 2Gb empty image"
dd if=/dev/zero of=temp.img bs=1 count=1 seek=2G


log "Enlarge the downloaded image by 2Gb"
cat temp.img >> IMAGE.img

log "fdisk magic to enlarge the main partition"

IMG_FILE="${STAGE_WORK_DIR}/IMAGE.img"

PARTED_OUT=$(parted -s "${IMG_FILE}" unit s print)
ROOT_OFFSET=$(echo "$PARTED_OUT" | grep -e '^ 2'| xargs echo -n \
    | cut -d" " -f 2 | tr -d B)

fdisk IMAGE.img <<EOF
d
2
n
p
2
$ROOT_OFFSET

n
w
EOF

# return
popd
