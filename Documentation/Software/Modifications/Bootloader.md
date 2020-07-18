# Updating the Boot Loader

Two block devices are available for the boot loader. 

| Device       | Size | Notes                                      |
| ------------ | ---- | ------------------------------------------ |
| mmcblk1boot0 | 4M   | Primary boot                               |
| mmcblk1boot1 | 4M   | Secondary boot (unused)                            |

While the primary device already contains the stock [U-Boot](../UBoot.md) installation, it should theoretically be possible to safely install a newer version on the secondary. It might require a hardware modification to choose between the two boot loaders.