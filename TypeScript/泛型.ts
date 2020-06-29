// 泛型函数
function genericity<T>(arg: T): T {
    return arg;
}
// 使用
let genericityOutput1 = genericity<string>("yashi");
let genericityOutput2 = genericity("yashi" as string);
let genericityOutput3 = genericity("yashi");

// 泛型变量
// 需要可能的长度属性用数组
function genericity2<T>(args: T[]): T[] {
    console.log(args.length)
    return args
}
function genericity3<T>(args: Array<T>): Array<T> {
    console.log(args.length)
    return args
}