#include <stdio.h>
int main()
{
    int maxf(float, float);
    float a, b, c, d, e;
    a = 3.5;
    b = 5.2;
    c = 4.6;
    d = maxf(b, c);
    e = maxf(d, a);
    printf("%f", e);
    return 0;
}
int maxf(float x, float y)
{
    return x > y ? x : y;
}