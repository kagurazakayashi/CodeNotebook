// 子类间读取属性
// 在 TypeScript 中，如果 类 C 想要访问类 B 的实例，而这两个对象都由 类 A 创建和管理，你可以通过 依赖注入（dependency injection）或 引用传递的方式，让 C 类持有 B 类的引用。

class B {
    public value: number;

    constructor(value: number) {
        this.value = value;
    }
}

class C {
    private b: B;

    constructor(b: B) {
        this.b = b;
    }

    printBValue() {
        console.log("B's value:", this.b.value);
    }
}

class A {
    private b: B;
    private c: C;

    constructor() {
        this.b = new B(42);
        this.c = new C(this.b); // 把 B 实例注入到 C
    }

    test() {
        this.c.printBValue(); // 输出 B 的 value
    }
}
