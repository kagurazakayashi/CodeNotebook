# MAC
brew install go

vim ~/.bash_profile
GOROOT=/usr/local/Cellar/go/1.13.4/libexec
export GOROOT
export GOPATH=/Users/yashi/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN:$GOROOT/bin
# wq
# GOROOT： go安装目录
# GOPATH：go工作目录
# GOBIN：go可执行文件目录
# PATH：将go可执行文件加入PATH中，使GO命令与我们编写的GO应用可以全局调用
source ~/.bash_profile


go run #运行当个.go文件
go install #在编译源代码之后还安装到指定的目录
go build #加上可编译的go源文件可以得到一个可执行文件
go get #= git clone + go install 从指定源上面下载或者更新指定的代码和依赖，并对他们进行编译和安装