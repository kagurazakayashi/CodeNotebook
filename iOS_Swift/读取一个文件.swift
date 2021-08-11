/*
Read in a File
Reading a file into an array of lines is not possible through an easy built-in like in other languages but we can create something short that doesn’t need a for using a combination of split and map:
和其他语言不同，Swift 不能使用内建的函数读取文件，并把每一行存放到数组中。不过我们可以结合 split 和 map 方法写一段简短的代码，这样就无需使用 for 循环：
*/

let path = NSBundle.mainBundle().pathForResource("test", ofType: "txt")

let lines = try? String(contentsOfFile: path!).characters.split{$0 == "\n"}.map(String.init)
if let lines=lines {
    lines[0] // O! for a Muse of fire, that would ascend
    lines[1] // The brightest heaven of invention!
    lines[2] // A kingdom for a stage, princes to act
    lines[3] // And monarchs to behold the swelling scene.
}

// That last step with map and the string constructor turns our arrays of characters into strings.
// 最后一步使用 map 函数和字符串的构造方法，将数组中的每个元素从字符数组（characters）转换为字符串。

// https://swift.gg/2016/04/18/10-Swift-One-Liners-To-Impress-Your-Friends/