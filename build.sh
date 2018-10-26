#!/bin/bash -e
# shellcheck disable=SC2119,SC1091

run_stage(){
	log "Begin ${STAGE_DIR}"
	STAGE="$(basename "${STAGE_DIR}")"
	pushd "${STAGE_DIR}" > /dev/null

    # Check wether to skip or not
	if [ ! -f SKIP ]; then
        # iterate different files
        for i in {00..99}; do
            if [ -x ${i}-run.sh ]; then
                log "Begin ${STAGE_DIR}/${i}-run.sh"
                ./${i}-run.sh
                log "End ${STAGE_DIR}/${i}-run.sh"
            fi
            if [ -f ${i}-run-chroot.sh ]; then
                log "Begin ${STAGE_DIR}/${i}-run-chroot.sh"
                on_chroot < ${i}-run-chroot.sh
                log "End ${STAGE_DIR}/${i}-run-chroot.sh"
            fi
        done
	fi

    # SKIP this stage next time
    touch ./SKIP
	popd > /dev/null
	log "End ${STAGE_DIR}"
}

if [ "$(id -u)" != "0" ]; then
	echo "Please run as root" 1>&2
	exit 1
fi

if [ -f config ]; then
	source config
fi

if [ -z "${IMG_NAME}" ]; then
	echo "IMG_NAME not set" 1>&2
	exit 1
fi

# Variables
export IMG_DATE="${IMG_DATE:-"$(date +%Y-%m-%d)"}"

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export SCRIPT_DIR="${BASE_DIR}/scripts"
export WORK_DIR="${WORK_DIR:-"${BASE_DIR}/work/${IMG_DATE}-${IMG_NAME}"}"
export DEPLOY_DIR=${DEPLOY_DIR:-"${BASE_DIR}/deploy"}
export LOG_FILE="${WORK_DIR}/build.log"

mkdir -p "${WORK_DIR}"
log "Begin ${BASE_DIR}"


export BASE_DIR

export CLEAN
export IMG_NAME
export APT_PROXY

export STAGE
export STAGE_DIR
export STAGE_WORK_DIR
export PREV_STAGE
export PREV_STAGE_DIR
export ROOTFS_DIR
export PREV_ROOTFS_DIR
export IMG_SUFFIX

# shellcheck source=scripts/common
source "${SCRIPT_DIR}/common"

# Iterate trough the steps
for STAGE_DIR in "${BASE_DIR}/stages"*; do
	run_stage
done

log "End ${BASE_DIR}"