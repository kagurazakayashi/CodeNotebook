#include <stdio.h>

int main() {
    // 打开文件以进行二进制读取
    FILE *file = fopen("binary.bin", "rb");
    if (file == NULL) {
        perror("文件打开失败");
        return 1;
    }

    // 读取文件中的每个字节，并打印其16进制表示
    unsigned char byte;
    while (fread(&byte, 1, 1, file)) {
        printf("%02X ", byte); // 打印每个字节的16进制表示
    }

    printf("\n");

    // 关闭文件
    fclose(file);
    return 0;
}
