# 先建 git 库

# 二、开发 TypeScript

# 1、建立项目目录
mkdir ts3
cd ts3
mkdir src
mkdir dist

# 2、初始化 NPM
npm init -y

# 3、安装 TypeScript
npm i -g typescript

# 4、创建并配置 tsconfig.json
tsc --init

# 现在项目结构如下
ls ts3
# dist  src  package.json  tsconfig.json

# 在 tsconfig.json 中取消下面属性项的注释，并修改其属性的值：
# "outDir": "./dist",
# "rootDir": "./src",
# 这样设置之后，我们在 ./src 中编码 .ts 文件，.ts 文件编译成 .js 后，输出到 ./dist 中。
# 转到文件 >>> tsconfig.json

# 5、Hello Typescript
echo "const hello: string = 'Hello, World!';">./src/index.ts
echo "console.log(hello);">>./src/index.ts
# 转到文件 >>> HelloWorld.ts
# 在项目的根目录下，执行下面的命令：
tsc
node ./dist/index.js
# Hello, World!
# tsc 是编译命令，详情查看：https://www.tslang.cn/docs/handbook/typescript-in-5-minutes.html
# tsc 的编译选项，详情查看：https://www.tslang.cn/docs/handbook/compiler-options.html

# 6、使用 Visual Studio Code 自动实时编译
# 手动编译还是比较麻烦，如果能够保存代码后，自动编译就好了。
# 详情查看：https://go.microsoft.com/fwlink/?LinkId=733558
# Ctrl + Shift + B 运行构建任务，将显示以下选项：
# 选择 tsc: 监视 - tsconfig.json ，回车运行之后，编辑的代码保存之后，就会自动编译。

# 三、代码检查
# 代码检查主要是用来发现代码错误、统一代码风格。
# 详情查看：https://ts.xcatliu.com/engineering/lint.html

# 1、安装 ESLint
# ESLint 可以安装在当前项目中或全局环境下，因为代码检查是项目的重要组成部分，所以我们一般会将它安装在当前项目中。可以运行下面的脚本来安装：
npm install eslint --save-dev
# 由于 ESLint 默认使用 Espree 进行语法解析，无法识别 TypeScript 的一些语法，故我们需要安装 typescript-eslint-parser，替代掉默认的解析器，别忘了同时安装 typescript：
npm install typescript typescript-eslint-parser --save-dev
# 由于 typescript-eslint-parser 对一部分 ESLint 规则支持性不好，故我们需要安装 eslint-plugin-typescript，弥补一些支持性不好的规则。
npm install eslint-plugin-typescript --save-dev
# 项目环境所有：
npm install eslint typescript typescript-eslint-parser eslint-plugin-typescript --save-dev
# 或全局环境所有：
npm install -g eslint typescript typescript-eslint-parser eslint-plugin-typescript

# 2、创建配置文件 .eslintrc.js
# ESLint 需要一个配置文件来决定对哪些规则进行检查，配置文件的名称一般是 .eslintrc.js 或 .eslintrc.json。
# 当运行 ESLint 的时候检查一个文件的时候，它会首先尝试读取该文件的目录下的配置文件，然后再一级一级往上查找，将所找到的配置合并起来，作为当前被检查文件的配置。
# 在项目的根目录下，执行下面的命令创建配置文件：
./node_modules/.bin/eslint --init
# 按需求，选择相应的选项：
# 转到文件 >>> eslint_init.md

# 编辑 .eslintrc.js (这步不需要了)
# 增加 'parser': 'typescript-eslint-parser', 替换掉默认的解析器 'parser': '@typescript-eslint/parser'，使之识别 TypeScript 的一些语法，如下面所示：
# module.exports = {
#   parser: 'typescript-eslint-parser',
#   env: {
#     es6: true,
#     node: true,
#   },
#   extends: 'airbnb-base',
#   globals: {
#     Atomics: 'readonly',
#     SharedArrayBuffer: 'readonly',
#   },
#   parserOptions: {
#     ecmaVersion: 2018,
#     sourceType: 'module',
#   },
#   'rules': {
#     'indent': ['warn', 4],
#   },
# };

# ['warn', 4] : 不是4个前置空格视为警告

# 3、在 VSCode 中集成 ESLint 检查
# 在编辑器中集成 ESLint 检查，可以在开发过程中就发现错误，极大的增加了开发效率。
# 要在 VSCode 中集成 ESLint 检查，我们需要先安装 ESLint 插件，点击「扩展」按钮，搜索 ESLint，然后安装即可。
# VSCode 中的 ESLint 插件默认是不会检查 .ts 后缀的，需要在「文件 => 首选项 => 设置」中，添加以下配置：

# {
#   "eslint.validate": [
#     "typescript"
#   ]
# }

# 4、无法解析到模块的路径
# 将下面代码echo到./src/index.ts中：
echo "import Cat from './Cat';">./src/index.ts
echo "">>./src/index.ts
echo "const kitty: Cat = new Cat('kitty');">>./src/index.ts
echo "kitty.say();">>./src/index.ts
# 将下面代码echo到./src/Cat.ts中：
echo "export default class Cat {">./src/Cat.ts
echo "  private name: string;">>./src/Cat.ts
echo "">>./src/Cat.ts
echo "  constructor(name: string) {">>./src/Cat.ts
echo "    this.name = name;">>./src/Cat.ts
echo "  }">>./src/Cat.ts
echo "">>./src/Cat.ts
echo "  say() {">>./src/Cat.ts
echo "    console.log(this.name);">>./src/Cat.ts
echo "  }">>./src/Cat.ts
echo "}">>./src/Cat.ts

# 保存之后，如果会提示这样的错误：
# Unable to resolve path to module './Cat'.eslint(import/no-unresolved)
# 解决办法是使用 eslint-import-resolver-alias ，先安装依赖，执行下面的命令：
npm install eslint-plugin-import eslint-import-resolver-alias --save-dev
# 然后，在 .eslintrc.js 配置中，加入 settings 字段：
#   settings: {
#     'import/resolver': {
#       alias: {
#         map: [
#           ['@', './src']
#         ],
#         extensions: ['.ts'],
#       },
#     },
#   },

# 四、调试 TypeScript
# 如何 F5 开始调试 TypeScript ，并且还具备断点调试功能，答案是，使用 TS-node。
# 详情查看：https://github.com/TypeStrong/ts-node

# 在项目的根目录下，执行下面的命令：
npm install -D ts-node
# 在 VScode 调试中，添加配置：
echo '{' >.vscode/launch.json
echo '  "version": "0.2.0",' >>.vscode/launch.json
echo '  "configurations": [' >>.vscode/launch.json
echo '    {' >>.vscode/launch.json
echo '      "type": "node",' >>.vscode/launch.json
echo '      "request": "launch",' >>.vscode/launch.json
echo '      "name": "Launch Program",' >>.vscode/launch.json
echo '      "runtimeArgs": [' >>.vscode/launch.json
echo '        "-r",' >>.vscode/launch.json
echo '        "ts-node/register"' >>.vscode/launch.json
echo '      ],' >>.vscode/launch.json
echo '      "args": [' >>.vscode/launch.json
echo '        "${workspaceFolder}/src/index.ts"' >>.vscode/launch.json
echo '      ]' >>.vscode/launch.json
echo '    }' >>.vscode/launch.json
echo '  ]' >>.vscode/launch.json
echo '}' >>.vscode/launch.json

# https://segmentfault.com/a/1190000018777683


# 配置网页服务

# 创建 index.html 网页并引用 js

# 启动项目我们安装live-server，来帮助我们启动一个服务器环境，live-server非常轻便且带有自动刷新功能，我们使用npm全局安装即可：
npm install -g live-server

# 安装完毕后，我们修改 package.json (不是launch.json)中的scripts如下：
# "scripts": {
#     "test": "tsc -w & live-server"
# }

# 在终端中输入npm t就可以启动项目了
npm t

# http://www.mishengqiang.com/index.php/101.html


# 错误 Uncaught ReferenceError: exports is not defined

# 安装 webpack
npm install --save-dev webpack webpack-cli

# 安装 ts-loader
# webpack只对js有效，因此我们需要把ts转化为js，需要用到该包
npm install --save-dev ts-loader

# 配置webpack
# 完成上述一系列，我们需要配置webpack让它为我们工作了。
# 在根目录，basic 下面新建文件webpack.config.js， 启动webpack对时候回去执行
# 转到文件 >>> webpack.config.js

# 修改packge.json
# "scripts": {
#   "test": "webpack" // test 可以换成自己喜欢的比如build 等等
# },

# 目前所有工作都结束了。然后可以运行了
npm run test