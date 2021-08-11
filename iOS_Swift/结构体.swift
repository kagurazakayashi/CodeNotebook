// 我们可以为结构体定义属性（常量、变量）和添加方法，从而扩展结构体的功能。
// 我们定义一个名为 MarkStruct 的结构体 ，结构体的属性为学生三个科目的分数，数据类型为 Int：
struct MarkStruct{
   var mark1: Int
   var mark2: Int
   var mark3: Int
}

// 我们可以通过结构体名来访问结构体成员。
// 结构体实例化使用 let 关键字：
import Cocoa

struct studentMarks {
   var mark1 = 100
   var mark2 = 78
   var mark3 = 98
}
let marks = studentMarks()
print("Mark1 是 \(marks.mark1)") //100
print("Mark2 是 \(marks.mark2)") //78
print("Mark3 是 \(marks.mark3)") //98


// 结构体实例是通过值传递而不是通过引用传递。
import Cocoa

struct markStruct{
    var mark1: Int
    var mark2: Int
    var mark3: Int
    
    init(mark1: Int, mark2: Int, mark3: Int){
        self.mark1 = mark1
        self.mark2 = mark2
        self.mark3 = mark3
    }
}

print("优异成绩:")
var marks = markStruct(mark1: 98, mark2: 96, mark3:100)
print(marks.mark1) //98
print(marks.mark2) //96
print(marks.mark3) //100

print("糟糕成绩:")
var fail = markStruct(mark1: 34, mark2: 42, mark3: 13)
print(fail.mark1) //34
print(fail.mark2) //42
print(fail.mark3) //13

// https://www.runoob.com/swift/swift-structures.html