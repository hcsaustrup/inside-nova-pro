# Applications

The applications are written in Go, and strangely enough the system actually comes with Go 1.7 installed.


## iotc_demon

While this application uses slightly more memory than `iotc_main`, it is still unknown what it does.


### File info

Y001:
```bash
$ file iotc_demon
iotc_demon: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, Go BuildID=2e4bcfdcdad47fb201ff66632407e15706f43abe, stripped

$ sha256sum iotc_demon
497c034d3d1ecacb1909175281bca2f8e85a179f4e5410543185f7645cdfddaf  iotc_demon
```

### Libraries

`iotc_demon` appears to use the following libraries:

* github.com/syndtr/goleveldb
* github.com/golang/snappy


### Network

`iotc_demon` doesn't appear to listen on any sockets.


### Open Files

`iotc_demon` has the following open files:

Y001:
```
$ lsof -p $(pgrep iotc_demon)
COMMAND    PID USER   FD   TYPE DEVICE SIZE/OFF   NODE NAME
iotc_demo 2762 root  cwd    DIR  179,2     4096 379021 /data/app
iotc_demo 2762 root  rtd    DIR  179,2     4096      2 /
iotc_demo 2762 root  txt    REG  179,2  3700656 379101 /data/app/iotc_demon
iotc_demo 2762 root  mem    REG  179,2   905332 290940 /lib/arm-linux-gnueabihf/libc-2.13.so
iotc_demo 2762 root  mem    REG  179,2   100447 290999 /lib/arm-linux-gnueabihf/libpthread-2.13.so
iotc_demo 2762 root  mem    REG  179,2    93472 291006 /lib/arm-linux-gnueabihf/ld-2.13.so
iotc_demo 2762 root    0r   CHR    1,3      0t0     96 /dev/null
iotc_demo 2762 root    1u   CHR  136,1      0t0      4 /dev/pts/1
iotc_demo 2762 root    2u   CHR  136,1      0t0      4 /dev/pts/1
iotc_demo 2762 root    3uW  REG  179,2        0 381946 /data/app/logs/logs.db.iotc_demon/LOCK
iotc_demo 2762 root    4w   REG  179,2     1952 381947 /data/app/logs/logs.db.iotc_demon/LOG
iotc_demo 2762 root    5w   REG  179,2        0 381962 /data/app/logs/logs.db.iotc_demon/000010.log
iotc_demo 2762 root    6w   REG  179,2       41 381973 /data/app/logs/logs.db.iotc_demon/MANIFEST-000011
```

## iotc_main

This application appears to be the busiest by far. It is also the only one that listens on TCP/UDP sockets. On an idle system, it's using around 5% CPU. This might indicate that it is also responsible for analyzing 433 MHz sensor data.

### File info

Y001:
```bash
$ file iotc_main
iotc_main: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, Go BuildID=6777c3c4a579d058626c5d708bf783959aafa98f, stripped

$ sha256sum iotc_main 
728acb31e17b698b8a3d437f5317d4ff02659fa031511afcd369e48a710bb552  iotc_main
```


### Libraries

`iotc_main` appears to use the following libraries:

* github.com/brutella/hc
* github.com/gin-contrib/sse
* github.com/gin-gonic/gin
* github.com/golang/protobuf
* github.com/golang/snappy
* github.com/gorilla/websocket
* github.com/mattn/go-isatty
* github.com/miekg/dns
* github.com/syndtr/goleveldb
* github.com/tarm/serial
* github.com/ugorji/go


### Network

`iotc_main` listens on the following sockets:

| Port | Protocol | Notes |
| ---- | -------- | ----- |
| 1949 | TCP      |
| 5353 | UDP      |
| 8077 | TCP      |

`iotc_main` has established several connections to `api.dinsafer.com` after booting:

```
Proto Recv-Q Send-Q Local Address Foreign Address         State       PID/Program name
tcp        0      0 ...:53127     api.dinsafer.com:https  ESTABLISHED 2794/iotc_main  
tcp        0      0 ...:53130     api.dinsafer.com:https  ESTABLISHED 2794/iotc_main  
tcp        0      0 ...:53131     api.dinsafer.com:https  ESTABLISHED 2794/iotc_main  
tcp        0      0 ...:53136     api.dinsafer.com:https  ESTABLISHED 2794/iotc_main  
tcp        0      0 ...:51510     api.dinsafer.com:http   ESTABLISHED 2794/iotc_main  
tcp        0      0 ...:53135     api.dinsafer.com:https  ESTABLISHED 2794/iotc_main  
tcp        0      0 ...:53133     api.dinsafer.com:https  ESTABLISHED 2794/iotc_main  
tcp        0      0 ...:53134     api.dinsafer.com:https  ESTABLISHED 2794/iotc_main  
tcp        0      0 ...:53132     api.dinsafer.com:https  ESTABLISHED 2794/iotc_main  
udp        0      0 ...:32868     api.dinsafer.com:7788   ESTABLISHED 2794/iotc_main  
```
After a while, this is reduced to just port 7788.

### Open Files

`iotc_main` has the following open files:

Y001:
```
$ lsof -p $(pgrep iotc_main)
COMMAND    PID USER   FD   TYPE DEVICE SIZE/OFF   NODE NAME
iotc_main 2794 root  cwd    DIR  179,2     4096 379021 /data/app
iotc_main 2794 root  rtd    DIR  179,2     4096      2 /
iotc_main 2794 root  txt    REG  179,2 12302920 282242 /data/app/iotc_main
iotc_main 2794 root    0r   CHR    1,3      0t0     96 /dev/null
iotc_main 2794 root    1w   CHR    1,3      0t0     96 /dev/null
iotc_main 2794 root    2w   CHR    1,3      0t0     96 /dev/null
iotc_main 2794 root    3r   CHR    1,9      0t0    100 /dev/urandom
iotc_main 2794 root    4u  0000    0,9        0     94 anon_inode
iotc_main 2794 root    5uW  REG  179,2        0 381950 /data/app/logs/logs.db.iotc_main/LOCK
iotc_main 2794 root    6w   REG  179,2     2998 381951 /data/app/logs/logs.db.iotc_main/LOG
iotc_main 2794 root    7w   REG  179,2        0 381948 /data/app/logs/logs.db.iotc_main/000016.log
iotc_main 2794 root    8w   REG  179,2       41 381970 /data/app/logs/logs.db.iotc_main/MANIFEST-000017
iotc_main 2794 root    9uW  REG  179,2        0 381959 /data/app/leveldb/leveldb.db/LOCK
iotc_main 2794 root   10w   REG  179,2   245205 381960 /data/app/leveldb/leveldb.db/LOG
iotc_main 2794 root   11r   REG  179,2     4351 381963 /data/app/leveldb/leveldb.db/001016.ldb
iotc_main 2794 root   12w   REG  179,2      299 381967 /data/app/leveldb/leveldb.db/MANIFEST-001012
iotc_main 2794 root   14w   REG  179,2   621301 381954 /data/app/leveldb/leveldb.db/001014.log
iotc_main 2794 root   15u   CHR 207,17      0t0    190 /dev/ttymxc1
iotc_main 2794 root   16uW  REG  179,2        0 381965 /data/app/logs/event.db.iotc_main/LOCK
iotc_main 2794 root   17w   REG  179,2     4493 381966 /data/app/logs/event.db.iotc_main/LOG
iotc_main 2794 root   18w   REG  179,2      174 381961 /data/app/logs/event.db.iotc_main/000024.log
iotc_main 2794 root   19w   REG  179,2      345 381968 /data/app/logs/event.db.iotc_main/MANIFEST-000025
iotc_main 2794 root   20r   REG  179,2      224 381953 /data/app/logs/event.db.iotc_main/000023.ldb
iotc_main 2794 root   21r   REG  179,2      224 381952 /data/app/logs/event.db.iotc_main/000020.ldb
iotc_main 2794 root   22u  IPv4   5493      0t0    UDP *:mdns 
iotc_main 2794 root   23u  IPv6   5495      0t0    UDP *:mdns 
iotc_main 2794 root   25u   CHR  166,0      0t0   5516 /dev/ttyACM0
iotc_main 2794 root   26u  sock    0,7      0t0   5511 can't identify protocol
iotc_main 2794 root   29u  IPv4   5534      0t0    UDP ...:32868->api.dinsafer.com:7788 
iotc_main 2794 root   30u  IPv6   5538      0t0    TCP *:8077 (LISTEN)
iotc_main 2794 root   32u  IPv6   5541      0t0    TCP *:1949 (LISTEN)
```
