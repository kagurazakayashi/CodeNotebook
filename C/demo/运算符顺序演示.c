// 运算符顺序演示
#include <stdio.h>
int main()
{
    int max;
    int a = 3, b = 5;
    max = a > b ? (a = 100) : (b = 50);
    printf("a = %d, b = %d, max = %d\n", a, b, max);
    return 0;
}
// a = 3, b = 50, max = 50