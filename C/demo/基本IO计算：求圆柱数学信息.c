#include <stdio.h>
int main()
{
    float r, h, l, s, sq, vq, vz;
    float pi = 3.1415926;
    // 请输入圆的半径和高度
    printf("Please input radical and the height:\n");
    scanf("%f%f", &r, &h);
    // 圆周长
    l = 2 * r * pi;
    // 圆面积
    s = pi * r * r;
    // 圆球表面积
    // sq = 4 * pi * r * r;
    sq = 4 * s;
    // 圆球体积
    // vq = 3 * pi * r * r * r / 4;
    vq = 3 * s * r / 4;
    // 圆柱体积
    vz = s * h;
    // 输入 1.5 3
    printf("圆周长为:        l = %6.2f\n", l);  // 9.42
    printf("圆面积为:        s = %6.2f\n", s);  // 7.07
    printf("圆球的表面积为: sq = %6.2f\n", sq); // 28.27
    printf("圆球体积为:     vq = %6.2f\n", vq); // 7.95
    printf("圆柱体积为:     vz = %6.2f\n", vz); // 21.21
    return 0;
}