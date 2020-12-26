/*
写一个判素数的函数，在主函数输入一个整数，输出是否为素数的信息。
*/
#include <stdio.h>
int main()
{
    int prime(int);
    int n;
    printf("Please input an integer:\n");
    scanf("%d", &n);
    int flag = prime(n);
    if (flag == 0)
        printf("n is not a prime\n");
    else
        printf("Yes!\n");
    return 0;
}
int prime(int n)
{
    int i, r;
    for (i = 2; i < n / 2; i++) // 素数不包含1和2
    {
        // 能不能被2所整除
        r = n % i;
        if (r == 0)
            return 0; // r或r/n中某一个数所整除，说明不是素数
    }
    return 1;
}
/*
17 : Yes!
 6 : n is not a prime
*/