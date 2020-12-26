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