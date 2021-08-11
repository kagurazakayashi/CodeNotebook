// 声明字符串
let str = "Guangzhou" // 单行
let qua = """
生活就像海洋，
只有意志坚强的人才能叨叨的到达彼岸
""" // 多行

// 初始化空字符串
var a = ""
var b = String()

// 字符串是值类型，常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝，实际的复制只发生在绝对必要的情况下，这意味着你将字符串作为值类型的同时可以获得极高的性能

// 字符串索引
let a = "Guten Tag!"
a[a.startIndex] = G 
// 结束字符下标 endIndex
a[a.Index(before:a.endIndex)] // !
// 开始字符下标 startIndex
a[a.Index(after:a.startIndex)] // u

// 字符串遍历 // indices 属性
for index in greeting.indices {
    print("\(greeting[index]) ", terminator: "")
}
// 打印输出 "G u t e n   T a g ! "

// 在字符串最后插入一个 !
var welcome = "hello"
welcome.insert("!", at: welcome.endIndex) // "hello!"

// 删除一个区间
let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)

// 子字符串
// 只保留逗号前面的 Hello
let a = "Hello, world!"
let index = a.firstIndex(of: ",") ?? a.endIndex
let b = a[..<index]
let newString = String(b) // 把结果转化为 String 以便长期存储
