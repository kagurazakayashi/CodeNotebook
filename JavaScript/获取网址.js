// 下面我们举例一个URL，然后获得它的各个组成部分：
// http://i.cnblogs.com/EditPosts.aspx?opt=1

// 1、window.location.href (设置或获取整个 URL 为字符串)
var test = window.location.href;
alert(test);
//  返回：http://i.cnblogs.com/EditPosts.aspx?opt=1

// 2、window.location.protocol (设置或获取 URL 的协议部分)
var test = window.location.protocol;
alert(test);
//返回：http:

// 3、window.location.host (设置或获取 URL 的主机部分)
var test = window.location.host;
alert(test);
//返回：i.cnblogs.com

// 4、window.location.port (设置或获取与 URL 关联的端口号码)
var test = window.location.port;
alert(test);
//返回：空字符(如果采用默认的80端口 (update:即使添加了:80)，那么返回值并不是默认的80而是空字符)

// 5、window.location.pathname (设置或获取与 URL 的路径部分（就是文件地址）)
var test = window.location.pathname;
alert(test);
//返回：/EditPosts.aspx

// 6、window.location.search (设置或获取 href 属性中跟在问号后面的部分)
var test = window.location.search;
alert(test);
//返回：?opt=1
// （PS：获得查询（参数）部分，除了给动态语言赋值以外，我们同样可以给静态页面，并使用javascript来获得相信应的参数值。）

// 7、window.location.hash (设置或获取 href 属性中在井号“#”后面的分段)
var test = window.location.hash;
alert(test);
//返回：空字符(因为url中没有)


// 8、js获取url中的参数值*

// 一、正则法
function getQueryString(name) {
    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
    var r = window.location.search.substr(1).match(reg);

    if (r != null) {
        return unescape(r[2]);
    }
    return null;
}
// 这样调用：
alert(GetQueryString("参数名1"));
alert(GetQueryString("参数名2"));
alert(GetQueryString("参数名3"));

// 二、split拆分法
function GetRequest() {
    var url = location.search; //获取url中"?"符后的字串
    var theRequest = new Object();

    if (url.indexOf("?") != -1) {
        var str = url.substr(1);
        strs = str.split("&");
        for (var i = 0; i < strs.length; i++) {
            theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);
        }
    }
    return theRequest;
}
var Request = new Object();
Request = GetRequest(); // var id=Request["id"]; 
// var 参数1,参数2,参数3,参数N;
// 参数1 = Request['参数1'];
// 参数2 = Request['参数2'];
// 参数3 = Request['参数3'];
// 参数N = Request['参数N'];

// 三、指定取
// 比如说一个url：http://i.cnblogs.com/?j=js, 我们想得到参数j的值，可以通过以下函数调用。
function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg); //获取url中"?"符后的字符串并正则匹配
    var context = "";
    if (r != null) context = r[2];
    reg = null;
    r = null;
    return context == null || context == "" || context == "undefined" ? "" : context;
}
alert(GetQueryString("j"));

// 四、单个参数的获取方法
function GetRequest() {
    var url = location.search; //获取url中"?"符后的字串
    if (url.indexOf("?") != -1) { //判断是否有参数
        var str = url.substr(1); //从第一个字符开始 因为第0个是?号 获取所有除问号的所有符串
        strs = str.split("="); //用等号进行分隔 （因为知道只有一个参数 所以直接用等号进分隔 如果有多个参数 要用&号分隔 再用等号进行分隔）
        alert(strs[1]); //直接弹出第一个参数 （如果有多个参数 还要进行循环的）
    }
}

// https://www.jianshu.com/p/073f79c5e438