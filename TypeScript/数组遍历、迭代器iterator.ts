function 迭代器iterator() {
    const array0 = [233, "yashi", true];
    for (let value of array0) {
        console.log(value);
    }
    const array1 = [22,33];
    // for..in 迭代对象的键，可操作任何对象
    for (let i in array1) {
        console.log(i); // 0,1
    }
    // for..of 迭代对象的值，关注迭代对象的值
    for (let i of array1) {
        console.log(i); // 22,33
    }
    // Map 和 Set 已经实现了 Symbol.iterator (ES6)
    const array2 = new Set(["www","yashi","moe"]);
    for (let v in array2) {
        console.log(v);
    }
    for (let v of array2) {
        console.log(v);
    }
}
// 迭代器iterator();