// 方式一：在定义对象时，直接添加属性和方法
function Person(name, age) {
    this.name = name;
    this.age = age;
    this.say = function () {
        alert(name + ':::' + age);
    }
}
var person = new Person('张三', 24);
person.say();

// 方式二：通过"对象.属性名"的方式添加
function Person() { }
var person = new Person();
person.name = '张三';
person.say = function () { alert(this.name) };
person.say();

// 方式三：通过prototype(原型)属性添加
// 注：需要使用构造方法添加！
function Person() { }
var person = new Person();
Person.prototype.name = '张三';
Person.prototype.say = function () { alert(this.name) };
person.say();

// https://blog.csdn.net/wqh0830/article/details/87880969