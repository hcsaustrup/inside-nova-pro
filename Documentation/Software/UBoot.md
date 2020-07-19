# U-Boot

The device uses [U-Boot](https://en.wikipedia.org/wiki/Das_U-Boot) to boot the operating system. You will need to access the boot loader to boot the device in single user mode or [boot over NFS](Modifications/NFSBoot.md). For this, you will need [access to the console](../Hardware/Modifications/Console.md).

For information about the operating system, go [here](OS).


## Environment

Below is the default environment for the device. Environment variables are used for configuration and scripting. An example of the latter, is the `boot` command, which actually runs the script defined in the `bootcmd` environment variable.

| Variable         | Value                                                                                                                                                                                                                                                                                                                                                                                          | Notes |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `baudrate`       | `115200`                                                                                                                                                                                                                                                                                                                                                                                       |
| `boot_fdt`       | `try`                                                                                                                                                                                                                                                                                                                                                                                          |
| `bootcmd`        | `if mmc rescan; then if run loadbootscript; then run bootscript; else if test ${bootdev} = sd1; then echo update emmc.........;run update_emmc;else echo mmc boot..........;if run loadimage; then run mmcboot; else run netboot; fi; fi; fi; else run netboot; fi;`                                                                                                                           |
| `bootcmd_mfg`    | `run mfgtool_args;bootz ${loadaddr} ${initrd_addr} ${fdt_addr};`                                                                                                                                                                                                                                                                                                                               |
| `bootdelay`      | `3`                                                                                                                                                                                                                                                                                                                                                                                            |
| `bootdev`        | `mmc2`                                                                                                                                                                                                                                                                                                                                                                                         |
| `bootscript`     | `echo Running bootscript from mmc ...; source`                                                                                                                                                                                                                                                                                                                                                 |
| `console`        | `ttymxc0`                                                                                                                                                                                                                                                                                                                                                                                      |
| `ethact`         | `FEC1`                                                                                                                                                                                                                                                                                                                                                                                         |
| `ethprime`       | `FEC`                                                                                                                                                                                                                                                                                                                                                                                          |
| `fdt_addr`       | `0x83000000`                                                                                                                                                                                                                                                                                                                                                                                   |
| `fdt_file`       | `imx6ul-14x14-evk.dtb`                                                                                                                                                                                                                                                                                                                                                                         |
| `fdt_high`       | `0xffffffff`                                                                                                                                                                                                                                                                                                                                                                                   |
| `filesize`       | `5e036`                                                                                                                                                                                                                                                                                                                                                                                        |
| `image`          | `zImage`                                                                                                                                                                                                                                                                                                                                                                                       |
| `initrd_addr`    | `0x83800000`                                                                                                                                                                                                                                                                                                                                                                                   |
| `initrd_high`    | `0xffffffff`                                                                                                                                                                                                                                                                                                                                                                                   |
| `ip_dyn`         | `yes`                                                                                                                                                                                                                                                                                                                                                                                          |
| `loadaddr`       | `0x80800000`                                                                                                                                                                                                                                                                                                                                                                                   |
| `loadbootscript` | `fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};`                                                                                                                                                                                                                                                                                                                                      |
| `loadfdt`        | `fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}`                                                                                                                                                                                                                                                                                                                                     |
| `loadimage`      | `fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}`                                                                                                                                                                                                                                                                                                                                        |
| `mfgtool_args`   | `setenv bootargs console=${console},${baudrate} rdinit=/linuxrc g_mass_storage.stall=0 g_mass_storage.removable=1 g_mass_storage.idVendor=0x066F g_mass_storage.idProduct=0x37FF g_mass_storage.iSerialNumber="" clk_ignore_unused `                                                                                                                                                           |
| `mmcargs`        | `setenv bootargs console=${console},${baudrate} root=${mmcroot}`                                                                                                                                                                                                                                                                                                                               |
| `mmcautodetect`  | `yes`                                                                                                                                                                                                                                                                                                                                                                                          |
| `mmcboot`        | `echo Booting from mmc ...; run mmcargs; if test ${boot_fdt} = yes || test ${boot_fdt} = try; then if run loadfdt; then bootz ${loadaddr} - ${fdt_addr}; else if test ${boot_fdt} = try; then bootz; else echo WARN: Cannot load the DT; fi; fi; else bootz; fi;`                                                                                                                              |
| `mmcdev`         | `1`                                                                                                                                                                                                                                                                                                                                                                                            |
| `mmcpart`        | `1`                                                                                                                                                                                                                                                                                                                                                                                            |
| `mmcroot`        | `/dev/mmcblk1p2 rootwait rw`                                                                                                                                                                                                                                                                                                                                                                   |
| `netargs`        | `setenv bootargs console=${console},${baudrate} root=/dev/nfs ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp`                                                                                                                                                                                                                                                                                   |
| `netboot`        | `echo Booting from net ...; run netargs; if test ${ip_dyn} = yes; then setenv get_cmd dhcp; else setenv get_cmd tftp; fi; ${get_cmd} ${image}; if test ${boot_fdt} = yes || test ${boot_fdt} = try; then if ${get_cmd} ${fdt_addr} ${fdt_file}; then bootz ${loadaddr} - ${fdt_addr}; else if test ${boot_fdt} = try; then bootz; else echo WARN: Cannot load the DT; fi; fi; else bootz; fi;` |
| `panel`          | `TFT70AB`                                                                                                                                                                                                                                                                                                                                                                                      |
| `script`         | `boot.scr`                                                                                                                                                                                                                                                                                                                                                                                     |
| `splashimage`    | `0x90000000`                                                                                                                                                                                                                                                                                                                                                                                   |
| `update_emmc`    | `mmc rescan;fatload mmc 0 ${loadaddr} /bin/${image}; fatload mmc 0 ${initrd_addr} /bin/ramdisk.img.u; fatload mmc 0 ${fdt_addr} /bin/imx6ul-14x14-evk.dtb; set bootargs console=${console},${baudrate} rdinit=/linuxrc; bootz ${loadaddr} ${initrd_addr} ${fdt_addr};`                                                                                                                         |


### Boot configuration

While not entirely the right way, the easiest way to modify boot parameters, is to modify `mmcroot`. Here are a few examples:

#### Normal boot

This will boot from the root partition on the MMC:

```
setenv mmcroot /dev/mmcblk1p2 rootwait panic=10 rw
boot
```

#### Direct to Bash

This will boot from the root partition on the MMC, but will bypass the normal System V initd startup, and run Bash as the first process. You will have full access to the filesystem, but you will be responsible for syncing and unmounting after writing.

```
setenv mmcroot /dev/mmcblk1p2 rootwait init=/bin/bash panic=10 rw
boot
```

Once booted, you can set a new root password with `passwd root`, followed by `sync` and `exit`. Wait 10 seconds for automatic panic reboot.

#### NFS boot

```
setenv mmcroot /dev/nfs ip=:::::eth1:dhcp nfsroot=XX.XX.XX.XX:/exports/nova02/root,v4,tcp panic=10 rw
boot
```

See [NFS booting](Modifications/NFSBoot.md).


### Network configuration

By default, the device doesn't have a Ethernet hardware address defined. This may confuse your DHCP server (i.e. router), so it's suggested to set this thorugh the environment. Example:

```
setenv ethaddr ca:fe:ba:be:00:02
save
```


### Resetting environment

To reset the environment, run this command:

```
env default -a -f
setenv bootdev mmc2
save
```


## Storage

See [Storage](Storage.md).


## Extracting data

While loading data from the MMC and dumping it in hex format to the terminal might sound like a viable solution, the available amount of RAM on the system will force you to cut the nearly 8GiB root filesystem partition up into numerous smaller pieces. This can be done, but it is quite tedious.

An easier solution would be to dump the image through SSH. Here is an example, dumping the `ext3` root filesystem partition to an image file:

```bash
$ ssh root@nova-02 -p 59282 'cat /dev/mmcblk1p2 | gzip --fast | base64' | base64 -d | gzip -d > rootfs.img
```

Since the default root password is unknown, **you will first have to set a new one** by booting the system [directly to Bash](UBoot.md#direct-to-bash).


## Misc

* https://wiki.dh-electronics.com/index.php/COM_iMX6_Bootloader_U-Boot - Different device, but has lots of interesting information, including how to unbrick.
* https://www.youtube.com/watch?v=TX3Ppe26emY - Video on booting Freescale i.MX6. Interesting bit about loading the kernel over Kermit.
