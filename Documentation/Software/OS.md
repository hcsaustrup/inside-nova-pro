# Operating System

## Introduction

The device is running [Debian](https://www.debian.org) GNU/Linux. So far we have only seen devices running [Debian 7.0 (*Wheezy*)](https://wiki.debian.org/DebianWheezy).

## Booting

For information about booting the operating system, read the [U-Boot page](UBoot.md).

# Access

The operating system is running `getty` on the console device, but requires username and password for shell access. Since the device is running an SSH daemon on port 59282, you might as well use that instead, once you have created a user in single user mode.

For information on console port access and booting the device in single user mode, see the [U-Boot page](UBoot.md).

The operating system starts an SSH daemon on port 59282. Passwords are not known at this point, so you will have to overwrite them.

## Packages

Being a Debian based system, the tool used for installing packages is `apt-get`. Unfortunately, the references repositories for Wheezy are no longer available, making it impossible to update or install additional packages without changing the configuration.

Current configuration (/etc/apt/sources.list):

```
deb http://ftp.cn.debian.org/debian/ wheezy main non-free contrib
deb http://ftp.cn.debian.org/debian/ wheezy-updates main non-free contrib
deb http://ftp.cn.debian.org/debian/ wheezy-backports main non-free contrib
deb-src http://ftp.cn.debian.org/debian/ wheezy main non-free contrib
deb-src http://ftp.cn.debian.org/debian/ wheezy-updates main non-free contrib
deb-src http://ftp.cn.debian.org/debian/ wheezy-backports main non-free contrib
```

When trying to use these repositories, you will get the following error:

```
W: 无法下载 http://ftp.cn.debian.org/debian/dists/wheezy/contrib/source/Sources  404  Not Found [IP: 45.125.0.6 80]
```

## Guides

### Update root user password

Here is a one-liner to update the root password to `password`:
```bash
$ usermod -p '$6$i.NHvRTy$1w.SVwrBdI8FZT.GFdda1RS2dKFlq5iO2G8vVQAF4U5wnkMw35LQWqo1uEGo3GJhWw44.QoZsf2kf1fwzodMW/' root
```

## Information

For boot logs, go [here](Bootlogs).

### Kernel

Y001:
```bash
$ uname -a
Linux S6EVO 3.14.38-6UL_ga+ge4944a5 #13 SMP PREEMPT Mon Jul 24 16:15:51 CST 2017 armv7l GNU/Linux
```

### CPU

Y001:
```bash
$ cat /proc/cpuinfo
processor	: 0
model name	: ARMv7 Processor rev 5 (v7l)
BogoMIPS	: 3.00
Features	: swp half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae 
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x0
CPU part	: 0xc07
CPU revision	: 5

Hardware	: Freescale i.MX6 UltraLite (Device Tree)
Revision	: 0000
Serial		: 0000000000000000
```

### Block devices

Y001:
```bash
$ lsblk
NAME         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
mmcblk1rpmb  179:24   0     4M  0 disk 
mmcblk1boot0 179:8    0     4M  1 disk 
mmcblk1boot1 179:16   0     4M  1 disk 
mmcblk1      179:0    0   7.2G  0 disk 
├─mmcblk1p1  179:1    0   500M  0 part 
└─mmcblk1p2  179:2    0   6.6G  0 part /
```

### USB devices

Y001:
```bash
$ lsusb
Bus 001 Device 002: ID 0424:2514 Standard Microsystems Corp. USB 2.0 Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 003: ID 0bda:b720 Realtek Semiconductor Corp. 
Bus 001 Device 008: ID 0483:5740 SGS Thomson Microelectronics 
```

### Network interfaces

Y001:
```bash
$ ifconfig
eth1      Link encap:Ethernet  HWaddr XX:XX:XX:XX:XX
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          ...

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          ...

sit0      Link encap:IPv6-in-IPv4  
          inet6 addr: ::127.0.0.1/96 Scope:Unknown
          UP RUNNING NOARP  MTU:1480  Metric:1
          ...

wlan0     Link encap:Ethernet  HWaddr XX:XX:XX:XX:XX:XX
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          ...
```

### Listening UDP/TCP sockets

Y001:
```
$ netstat -lnput
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:59282           0.0.0.0:*               LISTEN      1696/sshd       
tcp6       0      0 :::8077                 :::*                    LISTEN      9580/iotc_main  
tcp6       0      0 :::59282                :::*                    LISTEN      1696/sshd       
tcp6       0      0 :::1949                 :::*                    LISTEN      9580/iotc_main  
udp      ...      0 0.0.0.0:5353            0.0.0.0:*                           9580/iotc_main  
udp6     ...      0 :::5353                 :::*                                9580/iotc_main  
```
