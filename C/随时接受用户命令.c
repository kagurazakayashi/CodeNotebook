// 程序运行中可以接收用户输入
#include <stdio.h>
#include <signal.h>
int main(int argc, char* argv[])
{
    signal(SIGINT, sigHandle);
    printf("[READY] Initialization done. Press Q<Enter> or Ctrl+C to quit, Press V<Enter> switch verbose Mode.\n", rc);
    int ch;
    do
    {
        ch = getchar();
        if (ch == 'V' || ch == 'v') {
            printf("[INFO] Verbose Mode.\n");
        }
    } while (ch != 'Q' && ch != 'q');
    printf("[EXIT]\n");
    return 0;
}