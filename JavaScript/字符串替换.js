/* stringObject.replace(regexp/substr,replacement)

regexp/substr
必需。规定子字符串或要替换的模式的 RegExp 对象。
- 请注意，如果该值是一个字符串，则将它作为要检索的直接量文本模式，而不是首先被转换为 RegExp 对象。
- 字符串 stringObject 的 replace() 方法执行的是查找并替换的操作。它将在 stringObject 中查找与 regexp 相匹配的子字符串，然后用 replacement 来替换这些子串。如果 regexp 具有全局标志 g，那么 replace() 方法将替换所有匹配的子串。否则，它只替换第一个匹配子串。

replacement
必需。一个字符串值。规定了替换文本或生成替换文本的函数。
- replacement 可以是字符串，也可以是函数。如果它是字符串，那么每个匹配都将由字符串替换。但是 replacement 中的 $ 字符具有特定的含义。如下表所示，它说明从模式匹配得到的字符串将用于替换。
  - $1、...$99 与 regexp 中的第 1 到第 99 个子表达式相匹配的文本。
  - $& 与 regexp 相匹配的子串。
  - $` 位于匹配子串左侧的文本。
  - $' 位于匹配子串右侧的文本。
  - $$ 直接量符号。
*/

// 替换一次
var str = "Visit Microsoft!"
document.write(str.replace(/Microsoft/, "Google"))

// 替换所有
var str = "Welcome to Microsoft! "
str = str + "We are proud to announce that Microsoft has "
str = str + "one of the largest Web Developers sites in the world."
document.write(str.replace(/Microsoft/g, "Google"))

// 查找原字符串时不区分大小写
text = "javascript Tutorial";
text.replace(/javascript/i, "JavaScript");