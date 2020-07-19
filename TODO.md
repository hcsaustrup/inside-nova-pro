# TODO

* Uncover is this is actually a plain vanilla Debian or Linaro or Yocto or something like it.
* Try poking `/dev/ACM0` and `/dev/ttymxc1` and Minicom. This could be the RF radio and the GSM module.
* Figure out how `iotc_main` is communicating with the 433 MHz radio.
* Find a newer Linux distribution for the device. This requires knowledge of device trees.
* Build a Go application that can talk to the 433 MHz radio and other peripherals.
* Figure out how to select the secondary [boot loader](Documentation/Software/Modifications/Bootloader.md) device.

# In progress

# Done

* <strike>Find working ARMHF package repository for Debian Wheezy, allowing us to install additional packages.</strike> <br/> Solved by providing a new `sources.list` file.
* <strike>Figure out an easier way to gain access to the device.</strike><br/> Solved by documenting how to [boot directly to Bash](Documentation/Software/UBoot.md#direct-to-bash) from U-Boot.
* <strike>Update the [Net Booting](Documentation/Software/Modifications/NFSBoot.md) section.</strike><br/> Added information about configuring U-Boot and setting up an NFS server.
