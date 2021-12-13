# signal 信号列表

Linux 支持 POSIX 标准信号和实时信号。下面给出Linux Signal的简表，详细细节可以查看 `man 7 signal` 。

默认动作的含义如下：

| 信号      | 取值     | 动作 | 含义（发出信号的原因） |
| :-------- | :------: | :--: | :--------------------- |
| SIGHUP    | 1        | Term | 终端的挂断或进程死亡 |
| SIGINT    | 2        | Term | 来自键盘的中断信号 **(Ctrl+C)** |
| SIGQUIT   | 3        | Core | 来自键盘的离开信号 |
| SIGILL    | 4        | Core | 非法指令 |
| SIGABRT   | 6        | Core | 来自abort的异常信号 |
| SIGFPE    | 8        | Core | 浮点例外 |
| SIGKILL   | 9        | Term | 杀死 **(结束进程)** |
| SIGSEGV   | 11       | Core | 段非法错误(内存引用无效) |
| SIGPIPE   | 13       | Term | 管道损坏：向一个没有读进程的管道写数据 |
| SIGALRM   | 14       | Term | 来自alarm的计时器到时信号 |
| SIGTERM   | 15       | Term | 终止 |
| SIGUSR1   | 30,10,16 | Term | 用户自定义信号1 |
| SIGUSR2   | 31,12,17 | Term | 用户自定义信号2 |
| SIGCHLD   | 20,17,18 | Ign  | 子进程停止或终止 |
| SIGCONT   | 19,18,25 | Cont | 如果停止，继续执行 |
| SIGSTOP   | 17,19,23 | Stop | 非来自终端的停止信号 |
| SIGTSTP   | 18,20,24 | Stop | 来自终端的停止信号 |
| SIGTTIN   | 21,21,26 | Stop | 后台进程读终端 |
| SIGTTOU   | 22,22,27 | Stop | 后台进程写终端 |
| 　        |          |      | 　 |
| SIGBUS    | 10,7,10  | Core | 总线错误（内存访问错误） |
| SIGPOLL   |          | Term | Pollable事件发生(Sys V)，与SIGIO同义 |
| SIGPROF   | 27,27,29 | Term | 统计分布图用计时器到时 |
| SIGSYS    | 12,-,12  | Core | 非法系统调用(SVr4) |
| SIGTRAP   | 5        | Core | 跟踪/断点自陷 |
| SIGURG    | 16,23,21 | Ign  | socket紧急信号(4.2BSD) |
| SIGVTALRM | 26,26,28 | Term | 虚拟计时器到时(4.2BSD) |
| SIGXCPU   | 24,24,30 | Core | 超过CPU时限(4.2BSD) |
| SIGXFSZ   | 25,25,31 | Core | 超过文件长度限制(4.2BSD) |
| 　        |          |      | 　 |
| SIGIOT    | 6        | Core | IOT自陷，与SIGABRT同义 |
| SIGEMT    | 7,-,7    |      | Term |
| SIGSTKFLT | -,16,-   | Term | 协处理器堆栈错误(不使用) |
| SIGIO     | 23,29,22 | Term | 描述符上可以进行I/O操作 |
| SIGCLD    | -,-,18   | Ign  | 与SIGCHLD同义 |
| SIGPWR    | 29,30,19 | Term | 电力故障(System V) |
| SIGINFO   | 29,-,-   |      | 与SIGPWR同义 |
| SIGLOST   | -,-,-    | Term | 文件锁丢失 |
| SIGWINCH  | 28,28,20 | Ign  | 窗口大小改变(4.3BSD, Sun) |
| SIGUNUSED | -,31,-   | Term | 未使用信号(will be SIGSYS) |