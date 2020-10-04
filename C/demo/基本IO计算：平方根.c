#include <stdio.h>
#include <math.h> // sqrt 依赖
// 求 ax^2 + bx + c = 0 方程的根
// 设 b^2 - 4ac > 0
int main()
{
    double a, b, c;
    double p, q;
    double x1, x2;
    double delta;
    printf("please input a,b,c:\n");
    scanf("%lf%lf%lf", &a, &b, &c);              // 输入时空格间隔或回车间隔
    printf("a = %f, b = %f, c = %f\n", a, b, c); // DEMO: 1 3 2
    delta = b * b - 4.0 * a * c;
    printf("delta = %f\n", delta);
    if (delta < 0)
    {
        // 数据错误，不能继续运行
        printf("delta < 0"); // 测试
        return -1;
    }
    p = -b / 2.0 / a;
    p = -b / (2.0 * a);                     // 与上一行等价
    q = -sqrt(b * b - 4.0 * a * c) / 2 / a; // b平方 - 4ac 然后开方 /a
    x1 = p + q;
    x2 = p - q;
    // 7.2 : 小数点前 7 位（不够补空格）， 小数点后 2 位（不够补0）
    printf("The solution are: x1 = %7.2f, x2 = %7.2f\n", x1, x2);
    return 0;
}
