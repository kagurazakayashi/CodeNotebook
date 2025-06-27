# Windows通过串口提供CMD

## MSYS2 CLANG64

### cmd-wrapper.sh

```bash
#!/bin/bash
exec /c/Windows/System32/cmd.exe
```

### socat

```bash
pacman -S socat
ls /dev/ttyS*
# 波特率 115200，数据位 8，校验 Even，停止位 1，流控制 无
stty -F /dev/ttyS1 115200 cs8 parenb -parodd -cstopb -ixon -ixoff -crtscts
socat -d -d FILE:/dev/ttyS2,raw,echo=0 EXEC:./cmd-wrapper.sh,pty,stderr
```

### ~/c.bat

```batch
CHCP 65001
WHOAMI
cd %USERPROFILE%
C:\clink\.build\vs2022\bin\release\clink_x64.exe inject
```

## 开机启动

### ~/com.sh

```bash
/c/tools/msys64/usr/bin/stty -F /dev/ttyS1 115200 cs8 parenb -parodd -cstopb -ixon -ixoff -crtscts
/c/tools/msys64/usr/bin/socat -d -d FILE:/dev/ttyS1,raw,echo=0 EXEC:/home/yashi/cmd-wrapper.sh,pty,stderr
```

### startup/com.bat

```batch
C:\tools\msys64\usr\bin\bash.exe /home/yashi/com.sh
```
