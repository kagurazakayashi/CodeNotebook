function 声明变量() {
    let a = "yashi"
    const b = 3

    // bb = 2
    // error TS2588: Cannot assign to 'bb' because it is a constant.

    // aa = 6
    // error TS2322: Type '6' is not assignable to type 'string'.

    // 确定是哪个类型
    let c: any = "yashi"
    // 方法1（JSX类型断言不适用）：
    let cLength: number = (<string>c).length
    // 方法2：
    let cLength2: number = (c as string).length

    /*
    声明方式　变量提升　暂时性死区　重复声明　初始值　作用域
    var  　　允许　　　不存在　　　允许　　　不需要　除块级
    let  　　不允许　　存在　　　　不允许　　不需要　块级
    const　　不允许　　存在　　　　不允许　　需要　　块级

    变量提升：
    变量可在声明之前使用。
    暂时性死区：
    如果在代码块中存在 let 或 const 命令，这个区块对这些命令声明的变量，从一开始就形成了封闭作用域。凡是在声明之前就使用这些变量，就会报错。
        var tmp = 123;
        if (true) {
            tmp = 'abc';//报错，Uncaught ReferenceError: tmp is not defined
            let tmp;
        }
    重复声明：
    指在相同作用域内，重复声明同一个变量。let 和 const 命令声明的变量不允许重复声明。
    初始值：
    由于 const 声明的是只读的常量，一旦声明，就必须立即初始化，声明之后值不能改变。
    作用域：
    在 ES5 中只有全局作用域和函数作用域，没有块级作用域，这带来很多不合理的场景，内层变量可能会覆盖外层变量。

    https://juejin.im/post/6844903704189992973
    */
}