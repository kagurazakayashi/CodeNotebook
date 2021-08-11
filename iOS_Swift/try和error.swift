enum ErrorTest:Error {
    case nameVisiableError
    case ageError
    case heightError
    case nameLengthError
}
// 首先我们继承Error这个protocol，定义一下自己错误类型，后边可以根据自己的错误类型来判断是哪一种错误。
// 然后实现抛出异常函数throws:
func checkPerson(p:Person) throws -> String {
    guard p.age>0 && p.age<120 else {
        throw ErrorTest.ageError
    }
    guard p.name.count<10 && p.name.count>0 else {
        throw ErrorTest.nameVisiableError
    }
    return "success"
}
// 我们这边是使用throw ErrorTest.nameVisiableError来抛出不符合条件的异常情况，
// 然后捕捉函数：
let p2 = Person(age: 1000, name: "小明")

do {
    try str = checkPerson(p: p2)
    //不报错 下边会输出，报错则不执行
    print(str)
} catch  {
    //报错则执行相对应的错误类型
    switch error {
    case ErrorTest.ageError:
        print("ageError"); break
    case ErrorTest.nameLengthError:
        print("nameLengthError"); break
    case ErrorTest.nameVisiableError:
        print("nameLengthError"); break
    case ErrorTest.heightError:
        print("heightError"); break
    default:
        break
    }
}
// 定义一个年龄是1000的小明，年龄超出整除范围，实际输出是： ageError

// try  会执行函数之后抛出函数
// try? 是选择类型的执行，当报错的时候，返回nil，不报错的时候返回正常的值
// try! 是强制解包，当抛出异常的时候也解包，导致崩溃问题。
