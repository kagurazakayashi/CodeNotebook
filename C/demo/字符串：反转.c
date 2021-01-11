// 写一个函数，是输入的一个字符串按反序存放，在主函数中输入和输出字符串。
// 头指针和尾指针交换法：
#include <stdio.h>
#include <string.h>
int main()
{
    char inputStr[10];
    printf("Please enter a string of less than 10 characters:\n");
    scanf("%s", inputStr);
    int strLength = strlen(inputStr);
    char *strStart = inputStr;
    char *strEnd = inputStr + strLength - 1;
    while (strStart < strEnd)
    {
        char tempStr = *strStart;
        *strStart = *strEnd;
        *strEnd = tempStr;
        strStart++;
        strEnd--;
    }
    printf("The reversed string is: %s\n", inputStr);
    return 0;
}