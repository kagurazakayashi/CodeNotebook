@REM 修改windows虚拟内存

@REM 查看当前设置
wmic pagefile list /format:list

@REM #取消自动管理分页文件大小
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False

@REM #修改页面文件大小 最小1024MB，最大4096MB
wmic pagefileset where name="C:\pagefile.sys" set InitialSize=1024,MaximumSize=4096

@REM 重启生效
shutdown -r -t 0