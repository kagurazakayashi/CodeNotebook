#include <stdio.h>

int main() {
    // 打开文件以进行二进制读取
    FILE *file = fopen("binary.bin", "rb");
    if (file == NULL) {
        perror("文件打开失败");
        return 1;
    }

    // 读取文件中的每个字节，并打印其二进制表示
    unsigned char byte;
    while (fread(&byte, 1, 1, file)) {
        // 对每个字节的每位进行操作
        for (int i = 7; i >= 0; i--) {
            // 使用位移和位与操作来检查每一位
            printf("%d", (byte >> i) & 1);
        }
        printf(" "); // 在字节之间加空格以便阅读
    }

    printf("\n");

    // 关闭文件
    fclose(file);
    return 0;
}
