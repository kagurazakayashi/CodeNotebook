#include <stdio.h>
#include <math.h>

/*
写出下面各逻辑表达式的值，设a=3,b=4,c=5。
1. a+b>c&&b==c
2. a||b+c&&b-c
3. !(a>b)&&!c||1
4. !(x=a)&&(y=b)&&0
5. !(a+b)+c-1&&b+c/2
*/
int main3()
{
    int a = 3, b = 4, c = 5;
    int x, y, rt;
    rt = a + b > c && b == c;
    printf("rt 1 = %d\n", rt);
    rt = a || b + c && b - c;
    printf("rt 2 = %d\n", rt);
    rt = !(a > b) && !c || 1;
    printf("rt 3 = %d\n", rt);
    rt = !(x = a) && (y = b) && 0;
    printf("rt 4 = %d\n", rt);
    rt = !(a + b) + c - 1 && b + c / 2;
    printf("rt 5 = %d\n", rt);
    return 0;
}

/*
有3个整数a,b,c，由键盘输入，输出其中最大的数
*/
int main4()
{
    int a, b, c;
    scanf("%d%d%d", &a, &b, &c);
    int rt = a;
    if (b > rt)
        rt = b;
    if (c > rt)
        rt = c;
    printf("rt = %d\n", rt);
    return 0;
}

/*
从键盘输入一个小于1000的正数，要求输出它的平方根（如平方根不是整数，则输出其整数部分）。要求在输入数据后先对其进行检查是否为小于1000的正数。
*/
int main5()
{
    int z;
    scanf("%d", &z);
    double root;
    if (z > 1000 || z < 0)
    {
        printf("error data:\n");
        return 1;
    }
    root = sqrt(z);
    printf("%f\n", root);
    return 0;
}

/*
有一个函数：
    | x     (x<1)
y = | 2x-1  (1<=x<10)
    | 3x-11 (x>=10)
写程序，输入x的值，输出y相应的值
*/
int main6()
{
    double x, y;
    scanf("%lf", &x);
    if (x < 1)
        y = x;
    else if (x >= 1 && x < 10)
        y = 2 * x - 1;
    else
        y = 3 * x - 11;
    printf("x=%f,y=%f\n", x, y);
    return 0;
}