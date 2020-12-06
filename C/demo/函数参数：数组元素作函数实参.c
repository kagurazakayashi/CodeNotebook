#include <stdio.h>
int maxvalue, indexnum;
int main()
{
    void f(int arr[10]);
    int arr[10], i;
    printf("请输入10个整数\n");
    for (i = 0; i < 10; i++)
        scanf("%d", arr + i);
    f(arr);
    printf("maxvalue = %d, indexnum = %d\n", maxvalue, indexnum);
    return 0;
}
void f(int arr[10])
{
    int i;
    maxvalue = arr[0];
    indexnum = 0;
    for (i = 1; i < 10; i++)
    {
        if (arr[i] > maxvalue)
        {
            maxvalue = arr[i];
            indexnum = i;
        }
    }
}
/*
请输入10个整数
1 2 3 4 5 10 6 7 8 9
maxvalue = 10, indexnum = 5
*/