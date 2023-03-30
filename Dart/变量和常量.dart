// Flutter（Dart）基础——变量和常量

// 使用 var 声明变量，可赋予不同类型的值。
var name = 'budaye';

// 另一种方式是显式声明类型：
String name = 'budaye';

// 未初始化的变量默认值是 null。（即使变量是数字 类型默认值也是 null，因为在 Dart 中一切都是对象）
int count;
assert(count == null);
// 注意：在生产环境代码中 assert() 函数会被忽略，不会被调用。 在开发过程中, assert(condition) 会在非 true 的条件下抛出异常。

// dynamic类型
// dynamic 会告诉编译器，我们知道自己在做什么，不用做类型检测。
// dynamic类型是允许程序员在使用过程中动态地改变变量类型的类型：
dynamic name = "budaye";
print(name);
name = 18;
print(name);


/* 常量

final
final 修饰的变量的值只能被设置一次，可以称之为运行时常量。
final 要求变量只能初始化一次，并不要求赋的值一定是编译时常量，可以是常量也可以不是。

const
const 修饰的变量在程序编译的时候它的值就确定了，可以称之为编译时常量。
而 const 要求在声明时初始化，并且赋值必需为编译时常量。
*/


/* 可见性 公有/私有

与 Java 不同，在 Dart 中没有关键字 “public”、“protected” 和 “private” 。
如果一个标识符以下划线 _ 开头，则表示是私有的，否则表示公有的。
*/

// https://blog.csdn.net/u011578734/article/details/108584622
