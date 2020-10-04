// 求 ax^2+bx+c=0 的根
#include <stdio.h>
#include <math.h>
int main()
{
    double a, b, c, disc, x1, x2, p, q;
    scanf("%lf%lf%lf", &a, &b, &c);
    disc = b * b - 4 * a * c; // 计算 b2 - 4ac，disc 的值变为 -15
    if (disc < 0)
    {
        // -15 < 0为真
        printf("has not real roots\n"); // 没有实根
    }
    else
    {
        p = -b / (2.0 * a);
        q = sqrt(disc) / (2.0 * a); // sqrt 开根号
        // 也可以写为 sqrt(disc) / 2 / a
        x1 = p + q;
        x2 = p - q;
        printf("real roots:\nx1 = %7.2f\nx2 = %7.2f\n", x1, x2);
    }
    return 0;
}
/*
6 3 1
has not real roots
*/