TITLE 修复用户文件夹权限
CD C:\Users\yashi
ECHO 将文件夹的权限重置为继承自上一级目录的权限，*代表当前目录下的所有文件和子文件夹，/t表示递归处理所有子目录和文件，/q表示静默模式，不显示过程信息。
ICACLS * /reset /t
ECHO 重置当前目录权限。
ICACLS . /reset /t
ECHO 更改所有权到指定的用户。
ICACLS . /setowner "yashi" /t
ECHO 赋予指定用户完全控制权限。(OI)(CI)表示对象继承和容器继承。F表示完全访问权限。
ICACLS . /grant "yashi":(OI)(CI)F /t
ECHO 启用继承。
ICACLS . /inheritance:e /t
ECHO 完成以上步骤后，重启计算机以使更改生效。
