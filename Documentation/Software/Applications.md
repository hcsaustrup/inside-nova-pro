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

### Devices

`iotc_main` appears to have opened for following devices:

| Device       | Notes |
| ------------ | ----- |
| /dev/ttyACM0 |
| /dev/ttymxc1 |
