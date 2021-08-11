/*
Sum a list of numbers
This exercise is solved using reduce and the plus operator, leveraging the fact that the plus operator is a function, but the solution is obvious, we’ll see in a moment a few more creative uses of reduce.
求一组数字的和
这个问题可以通过使用 reduce 方法和加号运算符解决，这是因为加号运算符实际上也是一个函数。不过这个解法是非常显而易见的，待会儿我们会看到 reduce 方法更具有创造力的使用。
*/
(1...1024).reduce(0,combine: +)