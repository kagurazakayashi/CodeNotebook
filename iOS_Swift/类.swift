// 定义
class student{
    var studname: String
    var mark: Int 
    var mark2: Int

    init() // 构造函数(可选)
    {
        // 实例化后执行的代码
    }

    deinit { // 析构函数(可选)
        // 执行析构过程
    }
}
// 实例化类：
let studrecord = student()


// 实例
import Cocoa

class MarksStruct {
    var mark: Int
    init(mark: Int) {
        self.mark = mark
    }
}

class studentMarks {
    var mark = 300
}
let marks = studentMarks()
print("成绩为 \(marks.mark)") // 成绩为 300


// 类的属性可以通过 . 来访问。
// 格式为：实例化类名.属性名：
import Cocoa

class MarksStruct {
   var mark: Int
   init(mark: Int) {
      self.mark = mark
   }
}

class studentMarks {
   var mark1 = 300
   var mark2 = 400
   var mark3 = 900
}
let marks = studentMarks()
print("Mark1 is \(marks.mark1)") //Mark1 is 300
print("Mark2 is \(marks.mark2)") //Mark2 is 400
print("Mark3 is \(marks.mark3)") //Mark3 is 900


// 判定两个常量或者变量是否引用同一个类实例，Swift 内建了两个恒等运算符：
// 恒等运算符 ===
// 如果两个常量或者变量引用同一个类实例则返回 true
// 不恒等运算符 !==
// 如果两个常量或者变量引用不同一个类实例则返回 true
import Cocoa

class SampleClass: Equatable {
    let myProperty: String
    init(s: String) {
        myProperty = s
    }
}
func ==(lhs: SampleClass, rhs: SampleClass) -> Bool {
    return lhs.myProperty == rhs.myProperty
}

let spClass1 = SampleClass(s: "Hello")
let spClass2 = SampleClass(s: "Hello")

if spClass1 === spClass2 {// false
    print("引用相同的类实例 \(spClass1)")
}

if spClass1 !== spClass2 {// true
    print("引用不相同的类实例 \(spClass2)")
}

// 以上程序执行输出结果为：
// 引用不相同的类实例 SampleClass

// https://www.runoob.com/swift/swift-classes.html