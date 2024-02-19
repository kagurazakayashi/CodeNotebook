#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main() {
    char hexString[3];  // 存储用户输入的16进制字符串
    printf("请输入一个16进制数（两个字符）: ");
    scanf("%2s", hexString);

    // 将16进制字符串转换为字节
    unsigned char byte = (unsigned char)strtol(hexString, NULL, 16);

    // 打开文件进行二进制写入
    FILE *file = fopen("binary.bin", "wb");
    if (file == NULL) {
        perror("文件打开失败");
        return 1;
    }

    // 写入转换后的字节
    if (fwrite(&byte, 1, 1, file) != 1) {
        perror("写入错误");
        fclose(file);
        return 1;
    }

    // 关闭文件
    fclose(file);
    printf("数据已写入output_hex_to_binary.bin\n");

    return 0;
}
