@ECHO Kagurazaka Yashi Shell
@quser
@DATE /T
@TIME /T
@DOSKEY ls=DIR /b $*
@DOSKEY ln=mklink $*
@DOSKEY pwd=CHDIR $*
@DOSKEY rm=DEL $*
@DOSKEY cp=COPY $*
@DOSKEY mv=MOVE $*
@DOSKEY cat=TYPE $*
@DOSKEY clear=CLS $*
@DOSKEY exit=EXIT 0
@DOSKEY grep=FIND $*
@DOSKEY diff=COMP $*
@DOSKEY history=DOSKEY /h
@DOSKEY alias=DOSKEY $*
@DOSKEY chmod=ATTRIB $*
@DOSKEY lpr=PRINT $*
@DOSKEY free=MEM $*
@DOSKEY ps=TASKLIST $*
@DOSKEY fsck=SCANDISK $*
@DOSKEY debugfs=DEFRAG $*
@DOSKEY du=CHDISK $*
@DOSKEY traceroute=TRACERT $*
@DOSKEY ifconfig=IPCONFIG $*
@DOSKEY nslookup=NBTSTAT $*
@DOSKEY systemctl=NET $*
@DOSKEY htop=NTop $*
@DOSKEY which=where $*
@DOSKEY hosts=C:\Windows\System32\notepad.exe C:\Windows\System32\drivers\etc\hosts
@DOSKEY py=python $*
@DOSKEY sudo=sudo.vbs $*
@DOSKEY su=sudo.vbs cmd.exe