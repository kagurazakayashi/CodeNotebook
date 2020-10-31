/*
求 Sn = a + aa + aaa + ... + aa..a(n个a) 的值，其中 a 是一个数字，n 表示 a 的位数，n 由键盘输入。例如：
2 + 22 + 222 + 2222 + 22222 （此时 n = 5）
解：
2
---------v
2 x 10 + 2
----------vvvvvvvvvv
2 x 100 + 2 x 10 + 2
*/
#include <stdio.h>
#include <math.h>
int main()
{
    int a, n, i = 1, sn = 0, tn = 0;
    a = 2;
    n = 3;
    while (i <= n)
    {
        tn += a;
        sn += tn;
        a *= 10;
        ++i;
    }
    printf("%d", sn);
    return 0;
}
/*
1.
i = 1,
tn += a, tn = 2
sn += tn, sn = 2
cl *= 10, a = 20

2.
i = 2
tn = 22, sn = 24
a = 200

3.
i = 3
tn = 222, sn = 24 + 222
a = 2000
= 246
*/