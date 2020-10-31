/* 阶乘
求
20
 E n!
n=1
即求
1!+2!+3!+4!+...+20!
*/
#include <stdio.h>
int main()
{
    int n, i, sn = 0, tn;
    for (int n = 1; n <= 20; n++) //阶乘结果相加
    {
        tn = 1;
        for (i = 1; i <= n; i++) //求阶乘
            tn *= i;
        sn += tn;
    }
    printf("prodn = %d", sn);
    return 0;
}