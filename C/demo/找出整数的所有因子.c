#include <stdio.h>
int main()
{
    int x;
    scanf("%d", &x);
    int i = 1;
    for (i = 1; i <= x; ++i)
    {
        if (x % i == 0)
            printf("%3d\n", i);
    }
    i++;
    return 0;
}