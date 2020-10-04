#include <stdio.h>
#include <math.h>
int main()
{
    float p, r;
    int n;
    r = 0.1;
    n = 10;
    p = pow(1 + r, n);
    printf("p=%f\n", p);
    return 0;
}