enum class Week { //枚举关键字 enum 
    星期一, 星期二, 星期三, 星期四, 星期五, 星期六, 星期天
}

fun main(args: Array<String>) {
    println(Week.星期一)
    // 输出：星期一
    println("${Week.星期一}在Week中的索引是${Week.星期一.ordinal}")
    // 输出：星期一在Week中的索引是0
}