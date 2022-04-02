@REM 修改windows虚拟内存

@REM 查看当前设置
wmic pagefile list /format:list

@REM #取消自动管理分页文件大小
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False

@REM #修改页面文件大小 最小1024MB，最大4096MB
wmic pagefileset where name="C:\pagefile.sys" set InitialSize=1024,MaximumSize=4096

@REM 键入以下命令以设置虚拟内存的初始和最大大小，然后按 进入 ：
wmic pagefileset where name="C:\pagefile.sys" set InitialSize=YOUR-INIT-SIZE,MaximumSize=YOUR-MAX-SIZE

@REM 此示例将分页文件的初始和最大大小设置为 '9216' 和 '12288' 兆字节：
wmic pagefileset where name="C:\pagefile.sys" set InitialSize=9216,MaximumSize=12288

@REM 设置虚拟内存到E盘，并删除C盘下的页面文件,重启计算机后生效
wmic PageFileSet create name="E:\\pagefile.sys",InitialSize="1024",MaximumSize="1024"

@REM 重启生效
shutdown -r -t 0