fun printAll(strings: Collection<String>) {
    for(s in strings) print("$s ")
    println()
}

fun main() {
    val numbers = mutableListOf("one", "two", "three", "four")
    numbers.add("five") // 这是可以的
    //numbers = mutableListOf("six", "seven") // 编译错误

    val stringList = listOf("one", "two", "one")
    printAll(stringList)

    val stringSet = setOf("one", "two", "three")
    printAll(stringSet)
}