#include <stdio.h>
int main()
{
    int max4(int, int, int, int);
    int a, b, c, d;
    a = 1, b = 2, c = 3, d = 4;
    int e;
    e = max4(a, b, c, d);
    printf("四个数字中最大的为： %d", e);
}
int max4(int a, int b, int c, int d)
{
    int max2(int, int);
    int m;
    m = max2(a, b);
    m = max2(m, c);
    m = max2(m, d);
    // m = max2(max2(max2(a,b),c),d); 同上
    return m;
}
int max2(int a, int b)
{
    return a > b ? a : b;
}