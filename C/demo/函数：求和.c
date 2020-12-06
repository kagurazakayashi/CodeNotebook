#include <stdio.h>
float add(float x, float y)
{
    return x > y ? x : y;
}
int main()
{
    // float add(float, float); //放在此函数前面可以不声明，放在此函数后面必须声明
    float a, b, sum;
    a = 3.5;
    b = 5.9;
    sum = add(a, b);
    printf("%f", sum);
    return 0;
}