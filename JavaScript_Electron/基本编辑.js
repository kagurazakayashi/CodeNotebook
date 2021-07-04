// webContents
// https://electronjs.org/docs/api/web-contents

contents.undo()
// 在页面中执行undo编辑命令。

contents.redo()
// 在页面中执行redo编辑命令。

contents.cut()
// 在页面中执行cut编辑命令。

contents.copy()
// 在页面中执行copy编辑命令。

contents.copyImageAt(x, y)
// x Integer
// y Integer
// Copy the image at the given position to the clipboard.

contents.paste()
// 在页面中执行paste编辑命令。

contents.pasteAndMatchStyle()
// 在页面中执行pasteAndMatchStyle编辑命令。

contents.delete()
// 在页面中执行delete编辑命令。

contents.selectAll()
// 在页面中执行selectAll编辑命令。

contents.unselect()
// 在页面中执行unselect编辑命令。

contents.replace(text)
// 在页面中执行replace编辑命令。

contents.replaceMisspelling(text)
// 在页面中执行replaceMisspelling编辑命令。

contents.insertText(text)
// 插入text 到焦点元素

contents.findInPage(text[, options])
// text String - 要搜索的内容，必须非空。
// options Object (可选)

// forward Boolean (可选) -向前或向后搜索，默认为 true。
// findNext Boolean (optional) - Whether the operation is first request or a follow up, defaults to false.
// matchCase Boolean (optional) - Whether search should be case-sensitive, defaults to false.
// wordStart Boolean (optional) (Deprecated) - Whether to look only at the start of words. defaults to false.
// medialCapitalAsWordStart Boolean (optional) (Deprecated) - When combined with wordStart, accepts a match in the middle of a word if the match begins with an uppercase letter followed by a lowercase or non-letter. Accepts several other intra-word matches, defaults to false.
