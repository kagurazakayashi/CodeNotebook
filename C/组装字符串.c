// 组装字符串
#include <stdio.h>
#include <string.h>

int main(int argc, char* argv[])
{
    char str1[6] = "aaaaa\0"
    char *str2 = (char *) malloc(6);
    sprintf(str2, "%s", str1);
    printf("%s", str2);
    free(str2);
    return 0;
}