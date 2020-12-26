#include <stdio.h>
int main()
{
    int fac(int n);
    int i;
    for (i = 1; i <= 5; i++)
        printf("%d != %d\n", i, fac(i));
    return 0;
}
int fac(int n)
{
    static int f = 1; // 若非必要，不要多用静态局部变量
    f = f * n;
    return (f);
}