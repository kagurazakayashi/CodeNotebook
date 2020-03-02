package main

import (
    "fmt"
    "os"
    "os/signal"
)

func main() {
	// signal.Notify会将用户关注的信号转发到信道c, 信道c不能是阻塞的. 如果信道是缓冲不足的话, 可能会丢失信号. 如果我们不再次转发信号, 设置为1个缓冲大小就可以了.
    c := make(chan os.Signal, 1)
	// signal.Notify从第二个参数起是可变参数的, 用于指定要过滤的信号. 如果不指定第二个参数, 则默认是过滤全部的信号.
	// 不同的操作系统信号可能有差异. 不过syscall.SIGINT和syscall.SIGKILL各个系统是一致的, 分别对应os.Interrupt和os.Kill.
    signal.Notify(c, os.Interrupt, os.Kill)
    s := <-c
    fmt.Println("Got signal:", s)
}

// go run signal.go运行后会进入死循环, 按CTRL+C强制退出会看到以下的输出:
// Got signal: interrupt
// 当然, 直接从进程管理杀死程序就没办法收到信号的.
// 如果要恢复信号, 调用s.Signal(). 如果要停止信号的过滤, 调用signal.Stop(c).