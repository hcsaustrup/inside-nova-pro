# NFS Booting

## Assumptions

For this guide, we're assuming you're running CentOS on the NFS host machine. The mentioned commands will also work on Red Hat Enterprise Linux and Fedora and probably other SystemD and FirewallD based systems. The IP address of the NFS server is `10.69.0.92` and the directory `/exports/nova02/root` contains a bootable root filesystem for the i.MX6 system.

## Preparing the host

### Setting up NFS

Add the following to `/etc/exports` to expose the `/exports/nova02` directory:

```
/exports/nova02 *(rw,sync)
```

Install the NFS service, enable it and open firewall:

```
dnf install -y nfs-utils
systemctl enable --now nfs-server.service
firewall-cmd --add-service=nfs --permanent
firewall-cmd --reload
```

If you make any changes to `/etc/exports`, you can force the NFS service to reload it:

```
exportfs -av
```

### Copying the device root filesystem

TODO: Explain how to dump MMC partitions - probably on the U-Boot page.

Now mount the dumped image of the root filesystem:

```
mkdir -p /mnt/nova-root
mount mmcblk1p2.img /mnt/nova-root
```

And copy the files to exported NFS directory:

```
mkdir -p /exports/nova02/root
cd /mnt/nova-root
cp -av * /exports/nova02/root
```

Now is a good time to update the root password in `/etc/shadow`. Replace the encrypted password with `$6$i.NHvRTy$1w.SVwrBdI8FZT.GFdda1RS2dKFlq5iO2G8vVQAF4U5wnkMw35LQWqo1uEGo3GJhWw44.QoZsf2kf1fwzodMW/` to change it to `password`.

Taking a backup of the root filesystem is easily done from the NFS server:

```bash
$ cd /exports/nova02/root
$ tar -zcvf ../rootfs-backup.tar.gz \
    --exclude='./proc/*' \
    --exclude='./sys/*' \
    --exclude='./var/lib/cache/*' \
    --exclude='./var/log/*' \
    --exclude='./dev/*' \
    --exclude='./var/backups/*' \
    --exclude './var/cache/*' \
    --exclude './var/lib/apt/*' \
    --exclude './tmp/*' \
    --exclude './run/*' \
    .
```


## Preparing the device

### Configure the Boot Loader

Trick UBoot into applying NFS configuration even if it thinks it's booting from MMC:

```uboot
setenv mmcargs setenv bootargs console=${console},${baudrate} root=/dev/nfs ip=:::::eth1:dhcp nfsroot=10.69.0.92:/exports/nova02/root,v4,tcp panic=10
```

If you want to make these changes permanent:

```
save
```

Now boot the system:

```
boot
```

After a while, you should be presented with a login prompt:

```
Debian GNU/Linux 7 nova-02 ttymxc0
nova-02 login:
```

You should also be able to reach it with SSH on port 59282.

## What now?

Head over to [OS Tweaks](OSTweaks.md) for tips on tweaking the operating system.
