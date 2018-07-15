#!/bin/bash

# https://raspberrypi.stackexchange.com/questions/4943/resize-image-file-before-writing-to-sd-card
# https://stackoverflow.com/questions/24014493/unable-to-resize-root-partition-on-ec2-centos



# Create empty image
dd if=/dev/zero of=data/temp.img bs=1 count=1 seek=2G

# Append to original image
cat data/temp.img >> data/2018-06-27-raspbian-stretch-lite.img

# fdisk magic
fdisk data/2018-06-27-raspbian-stretch-lite.img <<EOF
d
2
n
p
2
98304

w
EOF

