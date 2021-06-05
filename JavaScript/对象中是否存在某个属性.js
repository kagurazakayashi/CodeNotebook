// 1. 使用in关键字。
// 该方法可以判断对象的自有属性和继承来的属性是否存在。
var o = { x: 1 };
"x" in o;        // true，自有属性存在
"y" in o;        // false
"toString" in o; // true，是一个继承属性

// 2. 使用对象的hasOwnProperty()方法。
// 该方法只能判断自有属性是否存在，对于继承属性会返回false。
var o = { x: 1 };
o.hasOwnProperty("x");        // true，自有属性中有x
o.hasOwnProperty("y");        // false，自有属性中不存在y
o.hasOwnProperty("toString"); // false，这是一个继承属性，但不是自有属性

// 3. 用undefined判断
// 自有属性和继承属性均可判断。
var o = { x: 1 };
o.x !== undefined;        // true
o.y !== undefined;        // false
o.toString !== undefined; // true
// 该方法存在一个问题，如果属性的值就是undefined的话，该方法不能返回想要的结果，如下。
var o = { x: undefined };
o.x !== undefined;        // false，属性存在，但值是undefined
o.y !== undefined;        // false
o.toString !== undefined; // true

// 4. 在条件语句中直接判断
var o = {};
if (o.x) o.x += 1; // 如果x是undefine,null,false," ",0或NaN,它将保持不变