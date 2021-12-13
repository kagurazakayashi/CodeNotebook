# vscode格式化文档与eslint冲突

`prettierrc.json`:

```
{
	//关闭格式化文档时自动加分号
	"semi": false,
	//使用单引号
	"singleQuote": true,
	//最后一行自动加逗号问题
	"trailingComma": "none"
}
```

# 关闭eslint中函数名与括号之间加空格的报错

打开.eslintrc.js文件，在rules里面添加一行代码：

`‘space-before-function-paren’: 0`

# 如果要关闭自动格式化文档可在settings.json中修改

```
"editor.formatOnSave": false,
"editor.formatOnType": false
```

或者在设置中搜索format将Format On Save 和 Format On Type取消勾选

<!-- https://blog.csdn.net/Komorebi_00/article/details/111886918 -->