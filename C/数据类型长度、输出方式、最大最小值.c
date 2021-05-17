/*
以下符号表示整数类型的范围限制

|    TYPE     |    MIN    |    MAX    |
| ----------- | --------- | --------- |
| char        | CHAR_MIN  | CHAR_MAX  |
| short       | SHRT_MIN  | SHRT_MAX  |
| int         | INT_MIN   | INT_MAX   |
| long        | LONG_MIN  | LONG_MAX  |
| long long   | LLONG_MIN | LLONG_MAX |
| float       | FLT_MIN   | FLT_MAX   |
| double      | DBL_MIN   | DBL_MAX   |
| long double | LDBL_MIN  | LDBL_MAX  |

无符号整数类型的下限均为0。
对应于无符号整数类型的上限的符号是：UCHAR_MAX，USHRT_MAX，UINT_MAX，ULONG_MAX 和 ULLONG_MAX。

https://www.yiibai.com/code/detail/12990
*/

#include <stdio.h>  // For command line input and output
#include <limits.h> // For limits on integer types
#include <float.h>  // For limits on floating-point types

int main(void){
    printf("Variables of type char store values from %d to %d\n", CHAR_MIN, CHAR_MAX);
    printf("Variables of type unsigned char store values from 0 to %u\n", UCHAR_MAX);
    printf("Variables of type short store values from %d to %d\n", SHRT_MIN, SHRT_MAX);
    printf("Variables of type unsigned short store values from 0 to %u\n", USHRT_MAX);
    printf("Variables of type int store values from %d to %d\n", INT_MIN,  INT_MAX);
    printf("Variables of type unsigned int store values from 0 to %u\n", UINT_MAX);
    printf("Variables of type long store values from %ld to %ld\n", LONG_MIN, LONG_MAX);
    printf("Variables of type unsigned long store values from 0 to %lu\n", ULONG_MAX);
    printf("Variables of type long long store values from %lld to %lld\n", LLONG_MIN, LLONG_MAX);
    printf("Variables of type unsigned long long store values from 0 to %llu\n", ULLONG_MAX);

    printf("\nThe size of the smallest positive non-zero value of type float is %.3e\n", FLT_MIN);
    printf("The size of the largest value of type float is %.3e\n", FLT_MAX);
    printf("The size of the smallest non-zero value of type double is %.3e\n", DBL_MIN);
    printf("The size of the largest value of type double is %.3e\n", DBL_MAX);
    printf("The size of the smallest non-zero value of type long double is %.3Le\n", LDBL_MIN);
    printf("The size of the largest value of type long double is %.3Le\n",  LDBL_MAX);

    printf("\n Variables of type float provide %u decimal digits precision. \n", FLT_DIG);
    printf("Variables of type double provide %u decimal digits precision. \n", DBL_DIG);
    printf("Variables of type long double provide %u decimal digits precision. \n", LDBL_DIG);
    int number = INT_MAX;

    printf("%d",number);
    return 0;
}


/*
| Constant | Meaning | Value |
| -------- | ------- | ----- |
| CHAR_BIT | Number of bits in the smallest variable that is not a bit field. | 8 |
| SCHAR_MIN | Minimum value for a variable of type `signed char`. | -128 |
| SCHAR_MAX | Maximum value for a variable of type `signed char`. | 127 |
| UCHAR_MAX | Maximum value for a variable of type `unsigned char`. | 255 (0xff) |
| CHAR_MIN | Minimum value for a variable of type `char`. | -128; 0 if /J option used |
| CHAR_MAX | Maximum value for a variable of type `char`. | 127; 255 if /J option used |
| MB_LEN_MAX | Maximum number of bytes in a multicharacter constant. | 5 |
| SHRT_MIN | Minimum value for a variable of type `short`. | -32768 |
| SHRT_MAX | Maximum value for a variable of type `short`. | 32767 |
| USHRT_MAX | Maximum value for a variable of type `unsigned short`. | 65535 (0xffff) |
| INT_MIN | Minimum value for a variable of type `int`. | -2147483647 - 1 |
| INT_MAX | Maximum value for a variable of type `int`. | 2147483647 |
| UINT_MAX | Maximum value for a variable of type `unsigned int`. | 4294967295 (0xffffffff) |
| LONG_MIN | Minimum value for a variable of type `long`. | -2147483647 - 1 |
| LONG_MAX | Maximum value for a variable of type `long`. | 2147483647 |
| ULONG_MAX | Maximum value for a variable of type `unsigned long`. | 4294967295 (0xffffffff) |
| LLONG_MIN | Minimum value for a variable of type `long long`. | -9,223,372,036,854,775,807 - 1 |
| LLONG_MAX | Maximum value for a variable of type `long long`. | 9,223,372,036,854,775,807 |
| ULLONG_MAX | Maximum value for a variable of type `unsigned long long`. | 18,446,744,073,709,551,615 (0xffffffffffffffff) |

https://docs.microsoft.com/en-us/cpp/c-language/cpp-integer-limits?view=msvc-160
*/