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
}