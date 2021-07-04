# Mac上node在安装后无法实现使用命令行卸载，需要手动删除一些文件夹。

# 方法一：
# 1. 删除/usr/local/lib中的所有node和node_modules
# 2. 删除/usr/local/lib中的所有node和node_modules的文件夹
# 3. 如果是从brew安装的, 运行brew uninstall node
# 4. 检查~/中所有的local, lib或者include文件夹, 删除里面所有node和node_modules
# 5. 在/usr/local/bin中, 删除所有node的可执行文件
# 6. 最后运行以下代码:
sudo rm /usr/local/bin/npm
sudo rm /usr/local/share/man/man1/node.1
sudo rm /usr/local/lib/dtrace/node.dsudo rm -rf ~/.npm
sudo rm -rf ~/.node-gyp
sudo rm /opt/local/bin/node
sudo rm /opt/local/include/node
sudo rm -rf /opt/local/lib/node_modules

# 方法二：先删除方法一文件，在运行以下指令：
sudo rm /usr/local/${i}
sudo rm -rf /usr/local/lib/node /usr/local/lib/node_modules /var/db/receipts/org.nodejs.*
sudo rm -rf /usr/local/include/node /Users/$USER/.npm

# 运行完毕后，重启终端，输入以下命令，查看是否卸载完毕nodenpm

# 链接：https://www.jianshu.com/p/3e0206dd23ac


# homebrew安装node.js
brew install node