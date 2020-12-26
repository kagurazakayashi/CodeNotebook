#include <stdio.h>
// 指针函数作为参数输入
int main()
{
    void fun(int, int, int (*p)(int, int));
    int maxf(int, int);
    int minf(int, int);
    int sumf(int, int);
    int (*p)(int, int);
    int m, c;
    printf("Please choose 1(maxmun) or 2(minmun):\n");
    scanf("%d", &c);
    if (c == 1)
        fun(3, 5, maxf);
    else if (c == 2)
        fun(3, 5, minf);
    else if (c == 3)
        fun(3, 5, sumf);
    return 0;
}

// 指针指向函数
int main2()
{
    int maxf(int, int);
    int minf(int, int);
    int (*p)(int, int);
    int m, c;
    printf("Please choose 1(maxmun) or 2(minmun):\n");
    scanf("%d", &c);
    if (c == 1)
        p = maxf;
    else
        p = minf;
    m = (*p)(3, 5);
    printf("The result is %d\n", m);
    return 0;
}

int maxf(int a, int b)
{
    return a > b ? a : b;
}
int minf(int a, int b)
{
    return a < b ? a : b;
}
int sumf(int a, int b)
{
    return a + b;
}
void fun(int x, int y, int (*p)(int, int))
{
    int result;
    result = (*p)(x, y);
    printf("The result is %d\n", result);
}
// 1 -> 5
// 2 -> 3
// 3 -> 8