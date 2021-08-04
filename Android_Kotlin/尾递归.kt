// 1、什么是尾递归？
// https://link.jianshu.com/?t=http%3A%2F%2Fwww.ruanyifeng.com%2Fblog%2F2015%2F04%2Ftail-call.html
// 尾递归 ：是指某个函数的最后一步依旧是调用自身
// kotlin中尾递归关键字 tailrec
// 2、为什么需要尾递归优化？
// 递归非常耗费内存，因为需要同时保存成千上百个调用记录，很容易发生"栈溢出"错误（stack overflow）。但 对于尾递归来说，由于只存在一个调用记录，所以永远不会发生"栈溢出"错误。

fun main(args: Array<String>) {
    println(accumulation(5, 1))
}

/**
 * tailrec 是尾递归函数的关键字
 * 尾递归函数是指，在该函数的最后一步操作中依旧是调用函数本身
 * 为了实现尾递归，我们定义了该方法接收两个参数：num 是我们传入的需要计算累加值得的变量，total用来接收最终的返回值
 */
tailrec fun accumulation(num: Int, total: Int): Int {
    return if (num == 1) {
        total
    } else {
        accumulation(num - 1, num + total)  //此时，该调用的含义是：先计算 total=num+total,然后计算 num=num-1
    }
}