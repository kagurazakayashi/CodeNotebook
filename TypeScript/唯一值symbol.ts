function 唯一值symbol() {
    // ES6 引入了一种新的原始数据类型 Symbol ，表示独一无二的值，它是 JavaScript 语言的第七种数据类型。
    // 创建
    const symbol1 = Symbol();
    const symbol2 = Symbol("hello");
    const symbol3 = Symbol("hello");
    // symbol2 === symbol3 // 此条件将始终返回 "false"，因为类型 "typeof symbol2" 和 "typeof symbol3" 没有重叠。
}