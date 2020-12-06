/*
用递归方法求 n!
求 n! 也可以用递归方法，即 5! 等于 4! × 5，而 4! = 3! × 4 ...， 1! = 1 。
可用下面的递归公式表示：
n! = { n! = 1    (n = 0,1)
     { n·(n-1)   (n > 1)
*/
#include <stdio.h>
#include <stdlib.h>

int main()
{
    int f(int);
    int c;
    c = fac(5);
    printf("c=%d\n", c);
    return 0;
}

int fac(int n) // 复制了 5 个副本
{
    int c;
    if (n == 1 || n == 0)
        c = 1;
    else
        c = n * fac(n - 1);
    return c;
}