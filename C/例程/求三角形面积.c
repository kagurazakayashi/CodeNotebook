#include <stdio.h>
#include <math.h>
int main()
{
    double a, b, c, s, area;
    // 对边长 a、b、c 赋值
    a = 3.67;
    b = 5.43;
    c = 6.21;
    s = (a + b + c) / 2; // 计算s
    // sqrt 数学函数，计算平方根
    area = sqrt(s * (s - a) * (s - b) * (s - c)); // 计算area
    // \t 转义字符，使输出位置跳到下一个tab位置
    printf("a=%f\tb=%f\t%f\n", a, b, c);
    printf("area=%f\n", area);
    return 0;
}
