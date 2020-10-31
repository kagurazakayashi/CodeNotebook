/*
一个球从 100m 高度自由落下，每次落地后反弹回原高度的一半，再落下，再反弹。
求它在第 10 次落地时共经过多少米，第 10 次反弹多高。
过程：
100 -> 50 -> 25 -> 12.5 -> 6.25 -> 1.125 -> ...
100 -> 100+50*2 -> 100+50*2+25*2 -> ...
100 / 2 / 2 / 2 / 2 / 2 .. -> +
*/
#include <stdio.h>
int main()
{
    double height = 100;
    double s;
    s = height;
    for (int i = 1; i < 10; i++)
    {
        height /= 2;
        s += height * 2;
    }
    printf("s =%16.10f, height = %16.10f\n", s, height / 2); // height / 2：第10次落地后再反弹的高度
    return 0;
}