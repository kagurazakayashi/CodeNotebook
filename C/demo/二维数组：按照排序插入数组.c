// 有一个已排好序的数组，要求输入一个数后，按原来排序的规律将它插入数组中。 //TODO:BUG
#include <stdio.h>
int main()
{
    int arr[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
    int x;
    printf("请输入一个要插入的元素：");
    scanf("%d", &x);
    if (x >= arr[8])
    {
        arr[9] = x;
    }
    else
    {
        arr[9] = arr[8];
        for (int i = 7; i >= 0; i--)
        {
            if (x <= arr[i])
            {
                arr[i + 1] = arr[i];
            }
            else
            {
                arr[i + 1] = x;
                break;
            }
            if (i == -1)
                arr[i + 1] = x;
        }
    }
    for (int j = 0; j < 10; j++)
        printf("%d ", arr[j]);
    return 0;
}