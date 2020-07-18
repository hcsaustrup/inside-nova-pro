# Tweaking the OS

This operating system is a minimal, expired, Chinese speaking version of Debian. Luckily there are a few things we can do to make the experience slightly less horrible.


### Prevent Alarm Application startup

Commenting out these lines in `/etc/rc.local` (skip the first line if you don't mind the console-noisy WLAN driver):

```
#modprobe 8723bu
#sh /data/scripts/start/all_startsh.sh
```

### Set the hostname

Update `/etc/hostname` with a hostname of your choice. Note: for this to work well with your DHCP server, you need to permanently set an Ethernet hardware address in U-Boot.


### Set English as default locale

Edit `/etc/locale.gen` and make sure this line is not commented out:

```
en_US.UTF-8 UTF-8
```

Now generate locales and select English as the new default:

```
locale-gen
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8
```


### Update the package repositories

Disable checks for expired releases by creating `/etc/apt/apt.conf.d/10-no-valid-until-check`:

```
Acquire::Check-Valid-Until 0;
```

Update `/etc/apt/sources.list` with working repositories. We're using the German mirror - your milage may vary:

```
# Security updates
deb     http://ftp.de.debian.org/debian-archive/debian-security/ wheezy/updates main non-free contrib
deb-src http://ftp.de.debian.org/debian-archive/debian-security/ wheezy/updates main non-free contrib

# Base packages
deb     http://ftp.de.debian.org/debian-archive/debian/ wheezy main non-free contrib
deb-src http://ftp.de.debian.org/debian-archive/debian/ wheezy main non-free contrib

# Updates (doesn't work)
#deb     http://ftp.de.debian.org/debian-archive/debian/ wheezy-updates main non-free contrib
#deb-src http://ftp.de.debian.org/debian-archive/debian/ wheezy-updates main non-free contrib

# Backports
deb     http://ftp.de.debian.org/debian-archive/debian/ wheezy-backports main non-free contrib
deb-src http://ftp.de.debian.org/debian-archive/debian/ wheezy-backports main non-free contrib
```

Clean and update package cache:

```
apt-get clean
apt-get update
```

Test by installing a few useful packages:

```
apt-get install minicom lsof tcpdump less
```


### Mount the boot filesystem

Add to `/etc/fstab`:

```
/dev/mmcblk1p1 /boot vfat defaults,ro 0 0
```

Note: This not where U-Boot is installed, merely where it loads the kernel and device tree from.
