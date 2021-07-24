// 定义一个空数组，存放或者取出制表位'\t'
var blanks = [];
// 遍历的函数主体
function getChildren(parent) {
    // 按着HTML里的缩进把遍历的元素打印出来
    // parent.nodeType === 1：节点是一个元素节点
    // parent.nodeType === 2：节点是一个属性节点
    console.log(blanks.join('') + parent.nodeType === 1 ? parent.nodeName : parent.nodeValue);
    // 当children不为0时进入条件判断
    if (parent.children.length > 0) {
        blanks.push("\t");
        // 递归遍历（深度遍历元素）
        for (var i = 0, len = parent.children.length; i < len; i++) {
            getChildren(parent.children[i]);
        }
        blanks.pop("\t");
    }
    // 调用函数主体
    getChildren(document);
}


// 获取页面中所有节点元素并存到数组中
var tags = document.getElementsByTagName('*');
var tagsArr = [];
function countTag(){
    for (var i = 0; i < tags.length; i++) {
        tagsArr.push((tags[i].tagName).toLowerCase());
    }
    // 获取到页面的所有标签
    console.log(tagsArr);
    //定义一个数组用于存放相同的元素
    var temp = [];
    //定义一个空数组用于存放每一个标签；
    var tag =[];
    for (var i = 0; i < tagsArr.length; i++) {
        for (var j = i+1; j < tagsArr.length+1; j++) {
            if (tagsArr[i] == tagsArr[j]) {
                temp.push(tagsArr[j]);
                tagsArr.splice(j,1);
                j--;
            }
            if (j == tagsArr.length -i) {
                temp.push(tagsArr[i]);
                tagsArr.splice(i,1);
                i--;
                tag.push(temp);
                temp = [];
            }
        }
    }
    return tag;
}
console.log(countTag());


// https://blog.csdn.net/maid_04/article/details/80002258