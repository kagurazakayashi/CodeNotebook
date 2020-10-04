// 输入实数，按代数值由小到大的顺序输出这两个数。
#include <stdio.h>
/*
int main()
{
    double x1, x2;
    printf("Please input two reals:\n");
    scanf("%f%f", &x1, &x2);
    printf("x1 = %f, x2 = %f\n", x1, x2);
    if (x1 > x2)
        printf("%f > %f", x1, x2);
    else
        printf("%f > %f", x2, x1);
    return 0;
}
*/
int main()
{
    int x, y, z, t;
    scanf("%d%d%d", &x, &y, &z);
    if (x > y)
    {
        // 复合语句：如果 x > y，交换 x y
        t = x;
        x = y;
        y = t;
    }
    // 从大到小:
    if (x < z)
    {
        t = x;
        x = z;
        z = t;
    }
    if (y < z)
    {
        t = y;
        y = z;
        z = t;
    }
    printf("x = %d, y = %d, z = %d\n", x, y, z);
    // 从小到大:
    if (x > y)
    {
        t = x;
        x = y;
        y = t;
    }
    if (x > z)
    {
        t = x;
        x = z;
        z = t;
    }
    if (y > z)
    {
        t = y;
        y = z;
        z = t;
    }
    printf("x = %d, y = %d, z = %d\n", x, y, z);
    return 0;
}