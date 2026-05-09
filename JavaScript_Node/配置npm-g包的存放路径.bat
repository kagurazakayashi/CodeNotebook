TITLE 配置npm-g包的存放路径

REM 查看/设置全局安装路径
npm config get prefix
npm config set prefix "D:\npm"

REM 查看/设置缓存路径（可以放 RAMDisk 重启清空）
npm config get cache
npm config set cache "B:\TMP"

REM 对应的 bash 环境变量
@REM export NPM_CONFIG_PREFIX=`npm config get prefix`
@REM export NPM_CONFIG_CACHE=`npm config get cache`

REM 确认路径是否已更新
npm config list

REM 为 Path 环境变量添加 D:\nodejs\node_global
REM + D:\npm (靠前)
REM + C:\Program Files\nodejs
where npm
REM D:\npm\npm
REM D:\npm\npm.cmd
REM C:\Program Files\nodejs\npm
REM C:\Program Files\nodejs\npm.cmd

REM 如果之前有旧的 npm 路径，请将其删除。
RD /S /Q %USERPROFILE%\AppData\Roaming\npm
