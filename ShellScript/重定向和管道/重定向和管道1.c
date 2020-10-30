#include <stdio.h>
int main(void)
{
    int a, b, sum;
    // 从默认标准输入设备输入 `stdin`
    // scanf("%d%d", &a, &b);
    // 相当于
    fscanf(stdin,"%d%d", &a, &b);
    sum = a + b;
    // 输出到标准输出 `stdout` 设备
    // printf("sum = %d\n", sum);
    // 相当于
    fprintf(stdout,"sum = %d\n", sum);
    // 输出到标准错误设备
    fprintf(stderr, "(E) %d + %d == %d\n",a,b,sum);
    return 0;
}