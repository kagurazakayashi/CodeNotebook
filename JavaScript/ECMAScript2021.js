// 替换字符串中的所有该关键字
const string = "it-is-just-a-test";
// 旧写法
string.replace(/-/g, "_");
// 新写法
string.replaceAll("-", "_");
// "it_is_just_a_test"

// AggregateError
// 一种新的 error type ，用于同时表示多个 error。

// Promise.any  https://pawelgrzybek.com/promise-combinators-explained/
const API = "https://api.github.com/users"
Promise.any([
    fetch(`${API}/pawelgrzybek`),
    fetch(`${API}/gabriel403`)
])
    .then(response => response.json())
    .then(({ name }) => console.log(`Cool dude is: ${name}`))
    .catch(error => console.error(error));

// WeakRef
// WeakRef 的一个实例创建了一个对给定对象的引用。
const obj = { spec: "ES2021" };
const objWeakRef = new WeakRef(obj);
objWeakRef.deref();
// 如果该对象仍然在内存中，则返回该对象。
// 如果目标对象已经被垃圾回收，则返回未定义的对象。

// FinalizationRegistry
// FinalizationRegistry 的实例在注册的目标对象被垃圾收集后触发回调函数。
const obj = { spec: "ES2021" };
const registry = new FinalizationRegistry(value => { console.log(`The ${value} object has been garbage collected.`) });
registry.register(obj, "ECMAScript 2021");
// 此时发生垃圾回收，输出：
// The ECMAScript 2021 object has been garbage collected.

// Logical Assignment Operators
// 只有当a为true时，才将a设为b
a &&= b;
// 只有当a为false时，才设置a为b
a ||= b;
// 只有当a为空时，才设置a为b
a ??= b;

// Numeric separators
const population = 37_653_260
console.log(population); // 37653260

// https://tc39.es/ecma262/2021/
// https://www.ecma-international.org/wp-content/uploads/ECMA-262_12th_edition_june_2021.pdf