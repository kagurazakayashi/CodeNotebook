#include <stdio.h>
void main()
{
    int x;
    double y;
    x = 3.1234567; // 小数赋值 int，小数被直接裁掉，不会发生四舍五入等
    y = x;
    printf("x=%d, y=%f\n", x, y); // x=3, y=3.000000
}
