#!/bin/bash

# apt dependencies: qemu qemu-user-static binfmt-support

set -e
set -o xtrace

DATA_DIR="$PWD/data"
MNT_DIR="$DATA_DIR/mnt"

function unmount {
	sudo umount -l "$MNT_DIR/sys"
	sudo umount -l "$MNT_DIR/proc"
	sudo umount -l "$MNT_DIR/dev/pts"
	sudo umount -l "$MNT_DIR/dev"

	sudo umount -l "$MNT_DIR/boot"
	sudo umount -l "$MNT_DIR/etc/resolv.conf"
	sudo umount -l "$MNT_DIR"
}

unmount