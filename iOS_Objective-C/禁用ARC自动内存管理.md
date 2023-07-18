# 禁用ARC

1. 工程名
2. `TARGETS`
3. `Build Setting`
4. 输入 `ARC` 进行搜索
5. 找到项 `Objective-c Automatic Reference Counting`
6. `YES` 都改为 `NO`，关闭自动内存管理成功。

## 部分文件禁用ARC

1. 工程名
2. `TARGETS`
3. `Build Phases`
4. `Compile Sources` 中找到你要手动管理内存的文件
5. 双击文件会出项一个方框，在方框中输入 `-fno-objc-arc` 即可。

- 如果你的工程是开启ARC的, 那就需要对某些文件禁用ARC: `-fno-objc-arc`
- 如果你的工程是关闭ARC的, 那就需要对某些文件开启ARC: `-fobjc-arc`
