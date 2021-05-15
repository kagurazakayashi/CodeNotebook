#include <stdio.h>
void copy_string(char *str1, char *str2)
{
    int i = 0;
    while (*(str1 + i) != '\0')
    {
        *(str2 + i) = *(str1 + i);
        i++;
    }
    *(str2 + i) = *(str1 + i);
}
void copy_string2(char str1[], char str2[])
{
    int i = 0;
    while (str1[i] != '\0')
    {
        str2[i] = str1[i];
        i++;
    }
    str2[i] = str1[i];
}
int main()
{
    char a[] = "I am a student";
    char b[15];
    copy_string(a, b);
    printf("string a : %s\n", a);
    printf("string a : %s\n", b);
    return 0;
}

/**
复制字符串（檢查長度，過濾結尾的換行符和結束符）
*  @param char *s1 從某個字串
*  @param char *s1 複製到某個字串
*  @param int maxLen 長度限制
*/
void cpCharArr(char *s1, char *s2, int maxLen) {
    if (strlen(s1) > maxLen) {
        printf("[CONFIG ERR] String \"%s\" should be less than %d characters.\n", s1, maxLen);
        return;
    }
    for (int i = 0; s1[i] != '\0'; ++i)
    {
        if (s1[i] == '\r' || s1[i] == '\n') continue;
        s2[i] = s1[i];
    }
}