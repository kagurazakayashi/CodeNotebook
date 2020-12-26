/*
将数组a中n个整数按相反顺序存放
思路：将 a[0] 与 a[n-1] 对换，…… 将 a[4] 与 a[5] 对换。
*/
#include <stdio.h>
int main()
{
    void exchange(int[], int);
    int arr[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0};
    int i;
    for (i = 0; i < 10; i++)
    {
        printf("%d ", arr[i]);
    }
    printf("\n"); // 1 2 3 4 5 6 7 8 9 0
    exchange(arr, 10);
    for (i = 0; i < 10; i++)
    {
        printf("%d ", arr[i]);
    }
    printf("\n"); // 0 9 8 7 6 5 4 3 2 1
    return 0;
}

void exchange(int a[], int n)
{
    int i, t;
    for (i = 0; i < n / 2; i++)
    {
        t = a[i];
        a[i] = a[n - i - 1];
        a[n - i - 1] = t;
    }
}

/*
指针版
*/
int main2()
{
    void sort(int[], int);
    int arr[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    int *p;
    p = arr;
    sort(p, 10);
    for (int i = 0; i < 10; i++)
        printf("%d ", *(p + i));
    printf("\n"); // 9 8 7 6 5 4 3 2 1 0
    return 0;
}

void sort(int a[], int n)
{
    int i, j, t;
    for (i = 0; i < n - 1; i++)
    {
        for (j = i + 1; j < n; j++)
        {
            if (a[i] < a[j])
            {
                t = a[i];
                a[i] = a[j];
                a[j] = t;
            }
        }
    }
}