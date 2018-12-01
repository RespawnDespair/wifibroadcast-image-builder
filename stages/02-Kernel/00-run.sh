set -e

# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

log "Remove previous Kernel"
rm -r linux || true

log "Download the Raspberry Pi Kernel"
git clone --depth=100 https://github.com/raspberrypi/linux

pushd linux
# Switch to specific commit
git checkout $GIT_KERNEL_SHA1


