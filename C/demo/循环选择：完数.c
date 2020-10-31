/*
一个数如果恰好等于它的因子之和，这个数就称为「完数」，
例如，6的因子为1,2,3，而6=1+2+3，因此6是「完数」。
编程序找出1000之内的所有完数，并按下面格式输出其因子：
6 its factors are 1,2,3
*/
#include <stdio.h>
int main()
{
    int i, num, s;
    for (num = 2; num <= 1000; num++)
    {
        s = 0;
        for (i = 1; i <= num / 2; i++)
        {
            if (num % i == 0)
                s += i;
        }
        if (s == num)
        {
            printf("%d, its factors are ", num);
            for (i = 1; i <= num / 2; i++)
            {
                if (num % i == 0)
                    printf("%d ", i);
            }
            printf("\n");
        }
    }
    return 0;
}
/*
6, its factors are 1 2 3
28, its factors are 1 2 4 7 14
496, its factors are 1 2 4 8 16 31 62 124 248
*/