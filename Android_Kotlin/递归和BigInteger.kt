import java.math.BigInteger

fun main(array: Array<String>) {
    val num = BigInteger("50") //声明BigInteger常量时传入一个字符串类型的数值
    println(fact(num))
}

fun fact(num: BigInteger): BigInteger {
    return if (num == BigInteger.ONE) {
        BigInteger.ONE
    } else {
        num * fact(num - BigInteger.ONE)
    }
}