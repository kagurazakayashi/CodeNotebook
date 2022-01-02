interface Greeter {
    (message: string): void;
}

function sayHi(greeter: Greeter) {
    greeter('Hello!');
}

sayHi((msg) => console.log(msg)); // msg is inferred as string