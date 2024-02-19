#include <stdio.h>
#include <string.h>

int main() {
    char binaryString[9];  // 用于存储用户输入的二进制字符串
    printf("请输入一个8位的二进制数: ");
    scanf("%8s", binaryString);

    // 检查是否只包含0和1
    for (int i = 0; i < 8; i++) {
        if (binaryString[i] != '0' && binaryString[i] != '1') {
            printf("输入非法，只能包含0和1。\n");
            return 1;
        }
    }

    // 将二进制字符串转换为单个字节
    unsigned char byte = 0;
    for (int i = 0; i < 8; i++) {
        byte = byte << 1;  // 左移一位
        if (binaryString[i] == '1') {
            byte = byte | 1; // 设置最低位为1
        }
    }

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
    printf("数据已写入output_binary_file.bin\n");

    return 0;
}
