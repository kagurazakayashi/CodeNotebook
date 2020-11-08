/*
a[0]  9] 8  8  8  8
a[1]  8] 9] 5  5  5
a[2]  5  5] 9] 4  4
a[3]  4  4  4] 9] 2
a[4]  2  2  2  2] 9]
a[5]  0  0  0  0  0]
...
a[0]  5] 4  4  4
a[1]  4] 5] 2  2
a[2]  2  2] 5] 0
a[3]  0  0  0] 5]
a[4]  8  8  8  8
a[5]  9  9  9  9
...
a[0]  2] 0
a[1]  0] 2]
a[2]  4  4
a[3]  5  5
a[4]  8  8
a[5]  9  9
*/
#include <stdio.h>
#define LEN 6
int main()
{
    int i, j, t;
    int a[LEN] = {9, 8, 6, 5, 3, 1};
    for (j = LEN - 1; j >= 1; j--)
    {
        for (i = 0; i < j; i++)
        {
            if (a[i] > a[i + 1])
            {
                t = a[i];
                a[i] = a[i + 1];
                a[i + 1] = t;
            }
        }
    }
    for (i = 0; i < LEN; i++)
        printf("%d ", a[i]);
    return 0;
}