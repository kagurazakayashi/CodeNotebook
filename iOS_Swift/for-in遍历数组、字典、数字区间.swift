// 遍历数组
let names = ["swift","Object-C","golang"]
for name in names {
     print("Hello \(name)")
}

// 遍历字典
let citys = ["Guangzhou":1,"ShenZhen":2]
for a , b in citys {
    print("city: \(a) city:\(b)")
}

// 遍历一段区域
for index in 1...5 {}

// 次幂运算例子
let base = 3
let power = 10
var answer = 1
for _ in 1...power{
    answer *= base
}
