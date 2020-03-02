/*
CTRL+C会向命令行进程发送中断信号, 在C语言的<signal.h>中的signal函数可以注册信号的处理函数.
signal函数的签名如下:
void (*signal(int sig, void (*func)(int)))(int);
*/

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

void sigHandle(int sig) {
    switch(sig) {
    case SIGINT:
        printf("sigHandle: %d, SIGINT\n", sig);
        break;
    default:
        printf("sigHandle: %d, OTHER\n", sig);
        break;
    }
    exit(1);
}

int main() {
    signal(SIGINT, sigHandle);
    for(;;) {}
    return 0;
}

/*
编译并运行程序后会进入死循环, 按CTRL+C强制退出会看到以下的输出:
sigHandle: 2, SIGINT
当然, 直接从进程管理杀死程序就没办法收到信号的.
<signal.h>中除了signal函数, 还有一个raise函数用于生成信号:
int raise(int sig);
我们在sigHandle截获信号之后如果想重新恢复信号, 可以使用raise函数. 但是, 要注意不要导致无穷递归signal/raise调用
*/