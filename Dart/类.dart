// Flutter（Dart）基础——类的详解

// 所有的类都继承自 Object 类。每个除 Object 类之外的类都只有一个超类，一个类的代码可以在其它多个类继承中重复使用。
// Extension 方法是一种在不更改类或创建子类的情况下向类添加功能的方式。

// 类的成员的访问

// 使用（.）来访问对象的实例变量或方法：
var p = Point(2, 2);
// 为实例变量 y 赋值。
p.y = 3;
// 获取 y 的值。
assert(p.y == 3);
// 调用变量 p 的 distanceTo() 方法。
double distance = p.distanceTo(Point(4, 4));

// 使用 ?. 代替 . 可以避免因为左边表达式为 null 而导致的问题：
// 如果 p 为非空则将其属性 y 的值设为 4
p?.y = 4;

// 构造函数的声明

// 声明一个与类名一样的函数即可声明一个构造函数（对于命名式构造函数 还可以添加额外的标识符）。大部分的构造函数形式是生成式构造函数，其用于创建一个类的实例：
class Point {
  double x, y;
  Point(double x, double y) {
    // 这里使用 this 关键字引用当前实例。
    this.x = x;
    this.y = y;
  }
}
// Dart 则提供了一种特殊的语法糖来简化该步骤：
class Point {
  double x, y;
  // 在构造函数体执行前用于设置 x 和 y 的语法糖。
  Point(this.x, this.y);
}
// 默认构造函数：如果你没有声明构造函数，那么 Dart 会自动生成一个无参数的构造函数并且该构造函数会调用其父类的无参数构造方法。
// 构造函数不被继承：子类不会继承父类的构造函数，如果子类没有声明构造函数，那么只会有一个默认无参数的构造函数。

// 命名式构造函数：可以为一个类声明多个命名式构造函数来表达更明确的意图：
class Point {
  double x, y;
  Point(this.x, this.y);
  // 命名式构造函数
  Point.origin() {
    x = 0;
    y = 0;
  }
}

/*
默认情况下，子类的构造函数会调用父类的匿名无参数构造方法，并且该调用会在子类构造函数的函数体代码执行前，如果子类构造函数还有一个 初始化列表，那么该初始化列表会在调用父类的该构造函数之前被执行，总的来说，这三者的调用顺序如下：

初始化列表 -> 父类的无参数构造函数 -> 当前类的构造函数

如果父类没有匿名无参数构造函数，那么子类必须调用父类的其中一个构造函数，为子类的构造函数指定一个父类的构造函数只需在构造函数体前使用（:）指定。
下面的示例中，Employee 类的构造函数调用了父类 Person 的命名构造函数:
*/
class Person {
  String firstName;
  Person.fromJson(Map data) {
    print('in Person');
  }
}
class Employee extends Person {
  // Person does not have a default constructor;
  // you must call super.fromJson(data).
  Employee.fromJson(Map data) : super.fromJson(data) {
    print('in Employee');
  }
}
main() {
  var emp = new Employee.fromJson({});
  // Prints:
  // in Person
  // in Employee
  if (emp is Person) {
    // Type check
    emp.firstName = 'Bob';
  }
  (emp as Person).firstName = 'Bob';
}
// 注意：传递给父类构造函数的参数不能使用 this 关键字，因为在参数传递的这一步骤，子类构造函数尚未执行，子类的实例对象也就还未初始化，因此所有的实例成员都不能被访问，但是类成员可以。

// TODO

// https://blog.csdn.net/u011578734/article/details/108601294