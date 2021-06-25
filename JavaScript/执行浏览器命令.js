// document.execCommand()方法处理Html数据时常用语法格式如下:
document.execCommand(sCommand[,交互方式, 动态参数])

// 其中：sCommand为指令参数（如下例中的"2D-Position"），交互方式参数如果是true的话将显示对话框，如果为false的话，则不显示对话框（下例中的"false"即表示不显示对话框），动态参数一般为一可用值或属性值（如下例中的"true"）。

document.execCommand("2D-Position","false","true");

/*
调用execCommand()可以实现浏览器菜单的很多功能. 如保存文件,打开新文件,撤消、重做操作…等等. 有了这个方法,就可以很容易的实现网页中的文本编辑器.

如果灵活运用,可以很好的辅助我们完成各种项目.

使用的例子如下:

1、〖全选〗命令的实现
[格式]:document.execCommand("selectAll")
[说明]将选种网页中的全部内容！
[举例]在之间加入：
全选

2、〖打开〗命令的实现
[格式]:document.execCommand("open")
[说明]这跟VB等编程设计中的webbrowser控件中的命令有些相似，大家也可依此琢磨琢磨。
[举例]在之间加入：
打开

3、〖另存为〗命令的实现
[格式]:document.execCommand("saveAs")
[说明]将该网页保存到本地盘的其它目录！
[举例]在之间加入：
另存为

4、〖打印〗命令的实现
[格式]:document.execCommand("print")
[说明]当然，你必须装了打印机！
[举例]在之间加入：
打印

Js代码 下面列出的是指令参数及意义
*/

//相当于单击文件中的打开按钮
document.execCommand("Open");

//将当前页面另存为
document.execCommand("SaveAs");

//剪贴选中的文字到剪贴板;
document.execCommand("Cut","false",null);

//删除选中的文字;
document.execCommand("Delete","false",null);

//改变选中区域的字体;
document.execCommand("FontName","false",sFontName);

//改变选中区域的字体大小;
document.execCommand("FontSize","false",sSize|iSize);

//设置前景颜色;
document.execCommand("ForeColor","false",sColor);

//使绝对定位的对象可直接拖动;
document.execCommand("2D-Position","false","true");

//使对象定位变成绝对定位;
document.execCommand("AbsolutePosition","false","true");

//设置背景颜色;
document.execCommand("BackColor","false",sColor);

//使选中区域的文字加粗;
document.execCommand("Bold","false",null);

//复制选中的文字到剪贴板;
document.execCommand("Copy","false",null);

//设置指定锚点为书签;
document.execCommand("CreateBookmark","false",sAnchorName);

//将选中文本变成超连接,若第二个参数为true,会出现参数设置对话框;
document.execCommand("CreateLink","false",sLinkURL);

//设置当前块的标签名;
document.execCommand("FormatBlock","false",sTagName);

//相当于单击文件中的打开按钮
document.execCommand("Open");

//将当前页面另存为
document.execCommand("SaveAs");

//剪贴选中的文字到剪贴板;
document.execCommand("Cut","false",null);

//删除选中的文字;
document.execCommand("Delete","false",null);

//改变选中区域的字体;
document.execCommand("FontName","false",sFontName);

//改变选中区域的字体大小;
document.execCommand("FontSize","false",sSize|iSize);

//设置前景颜色;
document.execCommand("ForeColor","false",sColor);

//使绝对定位的对象可直接拖动;
document.execCommand("2D-Position","false","true");

//使对象定位变成绝对定位;
document.execCommand("AbsolutePosition","false","true");

//设置背景颜色;
document.execCommand("BackColor","false",sColor);

//使选中区域的文字加粗;
document.execCommand("Bold","false",null);

//复制选中的文字到剪贴板;
document.execCommand("Copy","false",null);

//设置指定锚点为书签;
document.execCommand("CreateBookmark","false",sAnchorName);

//将选中文本变成超连接,若第二个参数为true,会出现参数设置对话框;
document.execCommand("CreateLink","false",sLinkURL);

//设置当前块的标签名;
document.execCommand("FormatBlock","false",sTagName);
/*
document对象execCommand通常在IE中在线处理Html数据时非常有用，它可以让你轻而易举实现文字的加粗、加颜色、加字体等一系列的命令。

D-Position 允许通过拖曳移动绝对定位的对象。
AbsolutePosition 设定元素的 position 属性为“absolute"(绝对)。
BackColor 设置或获取当前选中区的背景颜色。
BlockDirLTR 目前尚未支持。
BlockDirRTL 目前尚未支持。
Bold 切换当前选中区的粗体显示与否。
BrowseMode 目前尚未支持。
Copy 将当前选中区复制到剪贴板。
CreateBookmark 创建一个书签锚或获取当前选中区或插入点的书签锚的名称。
CreateLink 在当前选中区上插入超级链接，或显示一个对话框允许用户指定要为当前选中区插入的超级链接的 URL。
Cut 将当前选中区复制到剪贴板并删除之。
Delete 删除当前选中区。
DirLTR 目前尚未支持。
DirRTL 目前尚未支持。
EditMode 目前尚未支持。
FontName 设置或获取当前选中区的字体。
FontSize 设置或获取当前选中区的字体大小。
ForeColor 设置或获取当前选中区的前景(文本)颜色。
FormatBlock 设置当前块格式化标签。
Indent 增加选中文本的缩进。
InlineDirLTR 目前尚未支持。
InlineDirRTL 目前尚未支持。
InsertButton 用按钮控件覆盖当前选中区。
InsertFieldset 用方框覆盖当前选中区。
InsertHorizontalRule 用水平线覆盖当前选中区。
InsertIFrame 用内嵌框架覆盖当前选中区。
InsertImage 用图像覆盖当前选中区。
InsertInputButton 用按钮控件覆盖当前选中区。
InsertInputCheckbox 用复选框控件覆盖当前选中区。
InsertInputFileUpload 用文件上载控件覆盖当前选中区。
InsertInputHidden 插入隐藏控件覆盖当前选中区。
InsertInputImage 用图像控件覆盖当前选中区。
InsertInputPassword 用密码控件覆盖当前选中区。
InsertInputRadio 用单选钮控件覆盖当前选中区。
InsertInputReset 用重置控件覆盖当前选中区。
InsertInputSubmit 用提交控件覆盖当前选中区。
InsertInputText 用文本控件覆盖当前选中区。
InsertMarquee 用空字幕覆盖当前选中区。
InsertOrderedList 切换当前选中区是编号列表还是常规格式化块。
InsertParagraph 用换行覆盖当前选中区。
InsertSelectDropdown 用下拉框控件覆盖当前选中区。
InsertSelectListbox 用列表框控件覆盖当前选中区。
InsertTextArea 用多行文本输入控件覆盖当前选中区。
InsertUnorderedList 切换当前选中区是项目符号列表还是常规格式化块。
Italic 切换当前选中区斜体显示与否。
JustifyCenter 将当前选中区在所在格式化块置中。
JustifyFull 目前尚未支持。
JustifyLeft 将当前选中区所在格式化块左对齐。
JustifyNone 目前尚未支持。
JustifyRight 将当前选中区所在格式化块右对齐。
LiveResize 迫使 MSHTML 编辑器在缩放或移动过程中持续更新元素外观，而不是只在移动或缩放完成后更新。
MultipleSelection 允许当用户按住 Shift 或 Ctrl 键时一次选中多于一个站点可选元素。
Open 目前尚未支持。
Outdent 减少选中区所在格式化块的缩进。
OverWrite 切换文本状态的插入和覆盖。
Paste 用剪贴板内容覆盖当前选中区。
PlayImage 目前尚未支持。
Print 打开打印对话框以便用户可以打印当前页。
Redo 目前尚未支持。
Refresh 刷新当前文档。
RemoveFormat 从当前选中区中删除格式化标签。
RemoveParaFormat 目前尚未支持。
SaveAs 将当前 Web 页面保存为文件。
SelectAll 选中整个文档。
SizeToControl 目前尚未支持。
SizeToControlHeight 目前尚未支持。
SizeToControlWidth 目前尚未支持。
Stop 目前尚未支持。
StopImage 目前尚未支持。
StrikeThrough 目前尚未支持。
Subscript 目前尚未支持。
Superscript 目前尚未支持。
UnBookmark 从当前选中区中删除全部书签。
Underline 切换当前选中区的下划线显示与否。
Undo 目前尚未支持。
Unlink 从当前选中区中删除全部超级链接。
Unselect 清除当前选中区的选中状态。

关于document.execCommand：
要执行编辑命令，可调用 document.execCommand，并传递对应于命令 ID 的字符串。另外还有可选的第二个参数，该参数指定如果可以应用的话是否显示此命令的用户界面。传递整数 1 将显示用户界面，整数 0 将跳过它。这个参数通常不用于编辑命令。因为默认值为 0，所以假如您没有使用第三个参数（在这种情况下，还必须为第二个参数传递值），一般可以不管它。第三个参数也是可选的，在可应用的情况下，使用它来将任何所需参数传递给该命令。

Pixy方法受到IE的cache bug影响会闪烁。其实并没有说清楚这个问题，但其实该bug是有条件的，即IE的cache设置为Every visit to the page，而不是默认的Automatically。基本上，只有开发者才会把cache设置为每次访问检查更新，所以这个bug其实不会影响真正的用户（根据在winxpsp2的ie6下测试，虽然可能仍然调用了一次网络存取的api，但是并没有发生实际的请求，症状就是鼠标有极短时间的抖动，但是图像不会闪烁）。此外有人发现了一个未公开的方法来让IE对背景图进行缓存：
*/
document.execCommand("BackgroundImageCache",false,true)
/*
用这种方法甚至避免了api调用，貌似是直接缓存在IE内存中。

IE6下设置背景图片是不会被真正cache住的，就算服务器做了cache，如果想cache住只能~~~

做过UI设计和开发的人一定知道，IE(不包括IE7)会经常从服务器端重新载入背景图片，好端端的UI界面在IE(不包括IE7)中就这样被折腾着……

Erik发现了一个简单的解决办法（针对IE7以下的IE有效，其实在IE7中已经修复了这个Bug）
程序代码
*/
document.execCommand("BackgroundImageCache", false, true);


// 今天阅读Ext的源码时发现Jack Slocum已经考虑到了这一点，在Ext.js中给出了他的实现，在其它Ajax框架中应该还没有这种类似的代码，从这一个细节上就能看出Ext的全面～

var isIE = ua.indexOf("msie") > -1, isIE7 = ua.indexOf("msie 7″) > -1;
// remove css image flicker
if(isIE && !isIE7){
try{
document.execCommand("BackgroundImageCache", false, true);
}catch(e){}
}

// 今天阅读幻宇的dreamplayer播放器源码时发现幻宇也针对IE的背景缓存进行了修复，只是他并没考虑到IE7中已经不存在这个现象了，这是 evml.js中的一段相关代码～(顺便嘀咕两句：这家伙，写JS从来不加分号的，以前是这样，现在还是这样，这样的话怎么进行压缩呀，汗～下面的代码按照我的习惯都已加上分号，哪怕只有两三句而已～)

windows.isIE=navigator.appName.indexOf("Microsoft")==0;
if(isIE){
document.documentElement.addBehavior("#default#userdata");
document.execCommand("BackgroundImageCache",false,true);

// 来自 <http://blog.csdn.net/woshinia/article/details/18664903>
