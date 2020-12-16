#include <stdio.h>
#include <time.h>
int main()
{
    time_t timep;
    struct tm *p;
    time(&timep);
    // p=gmtime(&timep); // 获取gmt时间指针
    p = localtime(&timep);                      // 获取本地日历时间指针
    printf("tm_sec\t%d\n", p->tm_sec);          // 获取当前秒
    printf("tm_min\t%d\n", p->tm_min);          // 获取当前分
    printf("tm_hour\t%d\n", p->tm_hour);        // 获取当前时,gmtime的话获取西方的时间需要+8
    printf("tm_mday\t%d\n", p->tm_mday);        // 获取当前月份日数,范围是1-31
    printf("tm_mon\t%d\n", 1 + p->tm_mon);      // 获取当前月份,范围是0-11,所以要加1
    printf("tm_year\t%d\n", 1900 + p->tm_year); // 获取当前年份,从1900开始，所以要加1900
    printf("tm_yday\t%d\n", p->tm_yday);        // 从今年1月1日算起至今的天数，范围为0-365
    printf("%4d-%02d-%02d\n", 1900 + p->tm_year, 1 + p->tm_mon, p->tm_mday);
    printf("%02d-%02d-%02d\n", p->tm_hour, p->tm_min, p->tm_sec);
}