// 将JSON文本转换为对象。
JSON.parse(text, reviver);
// text
//    必选项。要转换为对象的JSON文本。
// reviver
//    可选项。该参数是个替换函数。在转换中，遍历的每个节点，都将执行该函数，该函数的返回值将替代转换结果的相应节点值。

// 将对象转换为JSON文本。
JSON.stringify(value, replacer, space);
// value
//    必选项。要转换为JSON文本的对象。
// reviver
//    可选项。该参数是个替换函数。在转换中，遍历的每个节点，都将执行该函数，该函数的返回值将替代转换结果的相应节点值。
// space
//    可选项。格式化输出JSON文本缩进的空格数量。如果不提供该参数将不会格式化输出。