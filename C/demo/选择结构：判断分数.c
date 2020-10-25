#include <stdio.h>
int main()
{
    int score;
    printf("Please input a score\n");
    scanf("%d", &score);
    // if 语句
    if (score >= 85)
        putchar('A');
    else if (score >= 70)
        putchar('B');
    else if (score >= 60)
        putchar('C');
    else
        putchar('D');
    // switch 语句
    switch (score / 10)
    {
    case 9:
    case 8:
        putchar('A');
        break;
    case 7:
        putchar('B');
        break;
    case 6:
        putchar('C');
        break;
    default:
        putchar('D');
    }
    return 0;
}