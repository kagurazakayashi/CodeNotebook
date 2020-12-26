/*
求方程 ax^2+bx+c=0 的根，用 3 个函数分别求当：
b^2-4ac 大于0、等于0、小于0 时的根并输出结果。
从主函数输入 a,b,c 的值。

ax^2 + bx + c = 0
△ = b^2 - 4ac
if △ > 0 : x1,2 = -b±√△ / 2a
if △ = 0 : x = - b/2a
if △ < 0 : 虚数（负根）
*/
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
double x1, x2, p, q;
int main()
{
    void gt(double, double, double);
    void lt(double, double, double);
    void et(double, double, double);
    double a, b, c;
    double disc;
    printf("Please input a,b,c:\n");
    scanf("%lf%lf%lf", &a, &b, &c);
    disc = b * b - 4 * a * c;
    if (disc > 0)
    {
        gt(disc, a, b);
        printf("The roots of the equation are: %lf and %lf, respectively\n", x1, x2);
        // 2 4 1 : The roots of the equation are: -0.292893 and -1.707107, respectively
        // 1 2 1 : The only root is -1.000000
        // 2 4 3 : The roots of the equation are: -1.000000+i0.707107 and -1.000000-i0.707107, respectively
    }
    else if (disc == 0)
    {
        et(disc, a, b);
        printf("The only root is %lf\n", x1);
    }
    else
    {
        lt(disc, a, b);
        printf("The roots of the equation are: %lf+i%lf and %lf-i%lf, respectively\n", p, q, p, q);
    }
    return 0;
}
void gt(double disc, double a, double b) // > 0
{
    x1 = (-b + sqrt(disc)) / 2 / a;
    x2 = (-b - sqrt(disc)) / 2 / a;
}
void lt(double disc, double a, double b) // < 0
{
    p = -b / 2 / a;
    q = sqrt(-disc) / a / a;
}
void et(double disc, double a, double b) // = 0
{
    x1 = x2 = -b / 2 / a;
}