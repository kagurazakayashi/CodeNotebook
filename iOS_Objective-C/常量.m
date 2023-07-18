// 利用#define定义常量
#define Time 3

// 用static和const来定义常量
static NSString *const name = @"jim";
// static表示只在当前.m文件可见，const表示不可改变的。

// 有时候需要对外公开某个常量的时候就用到extern，一般命名的名字前要加上当前类的前缀以避免名称冲突。
// .h
extern NSString *const Name;
// .m
NSString *const Name = @"jim";

/*
static – 只作用在编译单元，即只在当前.m文件可见
const  – 不可变
extern – 生成全局变量
*/
