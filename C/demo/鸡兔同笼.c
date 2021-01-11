// 鸡兔共有 30 只，脚共有 90 个，下面程序段是计算鸡兔各有多少只
#include <stdio.h>
int main()
{
    int x, y;
    for (x = 1; x <= 29; x++)
    {
        y = 30 - x;
        if (x * 2 + y * 4 == 90)
            printf("%d,%d\n", x, y);
    }
    return 0;
}