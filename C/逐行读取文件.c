// 逐行读取文件
#include <stdio.h>
#include <string.h>

int main(int argc, char* argv[])
{
    char file = "config.conf";
    FILE *fp;
    char line[1000];
    fp = fopen(file, "r");
    if (fp == NULL)
    {
        printf("[CONFIG] Can not load file!");
        return;
    }
    while (!feof(fp))
    {
        fgets(line,1000,fp);
        printf("[CONFIG] %s", line);
    }
    fclose(fp);
    return 0;
}