# figlet 编译安装
# 官网 http://www.figlet.org/
wget ftp://ftp.figlet.org/pub/figlet/program/unix/figlet-2.2.5.tar.gz
tar xvf figlet-2.2.5.tar.gz
cd figlet-2.2.5
make
make install

# 使用
figlet "文字"
figlet -f 字体名

# 列出所有样式
showfigfonts "文字"
