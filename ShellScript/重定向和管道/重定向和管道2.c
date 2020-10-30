#include <stdio.h>
int main(void)
{
    int n, i;
    scanf("%d", &n); // 从管道收取上一个程序输出的参数
    for (i = 0; i < n; i++)
    {
        printf("*"); // 字符全都转成 *
    }
    printf("\n");
    return 0;
}