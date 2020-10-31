/*
斐波那契数列指的是这样一个数列 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233，377，610，987，1597，2584，4181，6765，10946，17711，28657，46368........
这个数列从第3项开始，每一项都等于前两项之和。
*/
#include <stdio.h>
int main()
{
    int i, n, t1 = 0, t2 = 1, nextTerm;
    printf("输出几项: ");
    scanf("%d", &n);
    printf("斐波那契数列: ");
    for (i = 1; i <= n; ++i)
    {
        printf("%d, ", t1);
        nextTerm = t1 + t2;
        t1 = t2;
        t2 = nextTerm;
    }
    return 0;
}
// 输出几项: 10
// 斐波那契数列: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34,

int main2()
{
    int f[20] = {1, 1};
    int i;
    for (i = 2; i < 20; i++)
        f[i] = f[i - 1] + f[i - 2];
    for (i = 0; i < 20; i++)
    {
        printf("%12d", f[i]);
        if (i % 5 == 0) //如果 i 是 5 的倍数
            printf("\n");
    }
}