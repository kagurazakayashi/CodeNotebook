// 懒迭代器
console.log("===== 1 =====");
// 支持让一个函数暂停执行
function* generatorList1() {
    let i = 0;
    while (i < 3) yield i++;
}
let generatorGen1 = generatorList1(); // 直接调用时不会执行，而是创建一个对象
console.log(generatorGen1.next()); // { value: 0, done: false }
console.log(generatorGen1.next()); // { value: 1, done: false }
console.log(generatorGen1.next()); // { value: 2, done: false }
console.log(generatorGen1.next()); // { value: undefined, done: true }
console.log(generatorGen1.next()); // { value: undefined, done: true }

console.log("===== 2 =====");
function* generatorList2() {
    console.log("start");
    yield 0;
    console.log("resum");
    yield 1;
    console.log("end");
}
let generatorGen2 = generatorList2();
console.log(generatorGen2.next());
console.log(generatorGen2.next());
console.log(generatorGen2.next());
console.log(generatorGen2.next());
/*
start
{ value: 0, done: false }
resum
{ value: 1, done: false }
end
{ value: undefined, done: true }
{ value: undefined, done: true }

- generator 对象只会在调用 next 时开始执行
- 执行到 yield 时会暂停并返回 yield 的值
- 函数在 next 被调用时恢复执行
*/

console.log("===== 3 =====");
// 将 next 传到内部调用
function* generatorList3() {
    const who = yield;
    console.log("hi, " + who);
}
let generatorGen3 = generatorList3();
console.log(generatorGen3.next()); // { value: undefined, done: false }
console.log(generatorGen3.next("yashi")); // hi, yashi
// { value: undefined, done: true }
console.log(generatorGen3.next("yashi")); // { value: undefined, done: true }