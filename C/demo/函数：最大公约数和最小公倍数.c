/*
写两个函数，分别求两个整数的最大公约数和最小公倍数，用主函数调用这两个函数，并输出结果。两个整数由键盘输入。

求最大公约数
45 % 18 = 9
18 % 9 = 0
求最小公倍数
45 × 18 ÷ 9
*/
#include <stdio.h>
int main()
{
    int gongyue(int, int);
    int gongbei(int, int, int);
    int x, y, yue, bei;
    printf("Please input two integers:\n");
    scanf("%d%d", &x, &y); // 45 18
    yue = gongyue(x, y);
    bei = gongbei(x, y, yue);
    printf("最大公约数： %d\n", yue); // 9
    printf("最小公倍数： %d\n", bei); // 90
    return 0;
}
int gongyue(int x, int y)
{
    int m, r, t;
    if (x < y)
    {
        // 确保 x 比 y 大
        x = t;
        t = y;
        y = x;
    }
    m = x % y;
    while (m != 0)
    {
        // 辗转相除
        x = y;
        y = m;
        m = x % y;
    }
    r = y;
    return r; // 返回最大公约数
}
int gongbei(int x, int y, int r)
{
    return x * y / r;
}