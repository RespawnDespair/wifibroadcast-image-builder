# wifibroadcast-image-builder
Variation of befi's original image creation scripts. Uses latest kernel and patches.

In order to be able to run this you need a Debian or Ubuntu Linux machine with the following packages:

```
apt-get install qemu qemu-user-static binfmt-support
```

Then git clone this repository to a suitable folder and run:

```
./build_images.sh
```

This will start the process of downloading patching and building the image. Unfortunately the aircrack-ng package which is installed to the image requires manual confirmation, i have not found a way around this, so you need to keep an eye on the progress untill it shows the blue screen where you have to decide wether or not the functionality is available to all users. Then just press enter and the process should continue without further user intervention.
