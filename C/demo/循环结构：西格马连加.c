/* 求
100  50     10
 ∑k + ∑k^2 + ∑1/k
k=1  k=1    k=1
*/
#include <stdio.h>
int main()
{
    int sk, skk, k;
    double s_k;
    sk = 0;
    for (k = 1; k <= 100; k++)
    {
        sk += k;
    }
    skk = 0;
    for (k = 1; k <= 50; k++)
    {
        skk += k * k;
    }
    s_k = 0;
    for (k = 1; k <= 10; k++)
    {
        s_k += 1.0 / k;
    }
    printf("sk  = %d\n", sk);
    printf("skk = %d\n", skk);
    printf("s_k = %f\n", s_k);
    printf("->> = %f\n", sk + skk + s_k);
    return 0;
}