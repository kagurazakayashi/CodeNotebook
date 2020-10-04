/*
有一函数:
    | -1 (x < 0)
y = |  0 (x = 0)
    |  1 (x > 0)
编一程序，输入一个x值，要求输出相应的y值。
- 用if语句检查x的值，根据x的值决定赋予y的值
- 由于y的可能值不是两个而是三个，因此不可能只用一个简单的(无内嵌if)的if语句来实现

方法1：
先后用3个独立的if语句处理：
输入x
若 x < 0, 则y =-1
若 x = 0, 则y = 0
若 x > 0, 则y = 1
scanf("%d",&x);
if(x<0)    y = -1;
if(x==0)  y = 0;
if(x>0)    y = 1;
printf("x=%d,y=%d\n",x,y);

方法2：
用一个嵌套的if语句处理：
输入x
若x < 0, 则y = -1
否则
    若 x = 0, 则y = 0
    否则   y = 1
输出x和y
scanf("%d",&x);
if(x<0)  y=-1;
else
    if(x==0) y=0;
    else  y=1;
printf("x=%d,y=%d\n",x,y);
*/
#include <stdio.h>
int main()
{
    int x, y;
    printf("Please input a integer:\n");
    scanf("%d", &x);
    if (x >= 0)
        if (x > 0)
            y = 1;
        else
            y = 0;
    else
        y = -1;
    printf("y=%d\n", y);
    return 0;
}