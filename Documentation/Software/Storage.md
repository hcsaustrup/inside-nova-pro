# Storage

## Disks

All storage resides an NVRAM chip on the [SOM](../Hardware/SOM.md). While only one physical chip, in Linux, it appears as 4 different disks:

| Device       | Size | Notes                                      |
| ------------ | ---- | ------------------------------------------ |
| mmcblk1rpmb  | 4M   | ?                                          |
| mmcblk1boot0 | 4M   | Primary boot loader ([U-Boot](UBoot.md))   |
| mmcblk1boot1 | 4M   | Secondary boot loader (unused)             |
| mmcblk1      | 7.2G | Available for kernels and operating system |

Feeling adventurous? Consider updating the [Boot Loader](Modifications/Bootloader.md).

## Partitions

The `mmcblk1` disk is partitioned into two partitions:

| Device    | Size | Part. Type   | Filesystem | Mount Point | Notes                                    |
| --------- | ---- | ------------ | ---------- | ----------- | ---------------------------------------- |
| mmcblk1p1 | 500M | 0x0c (FAT32) | vfat       | (/boot)     | Kernel (zImage), device tree files (dtb) |
| mmcblk1p2 | 6.6G | 0x83 (Linux) | ext3       | /           | Operating system                         |
