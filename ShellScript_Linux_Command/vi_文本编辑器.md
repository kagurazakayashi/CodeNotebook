# vi (Visual) 文本编辑器 、vim 配置

启动 vi: `vi [filename]`

# 两种模式

vi 编辑器命令采用快捷键，如果输入一个字符可能是文件内容也可能是命令，所以提供两种模式：

- `命令模式` ( `Command Mode` )，输入控制命令。
- `插入模式` ( `Insert Mode` )，编辑文件。

## 启动 vi 时，进入`命令模式`。

- 在插入模式时，按 `Esc` 进入`命令模式`。
- 输入插入命令，进入`插入模式`。插入模式进入命令：
  - `a`: 从 光标 后面 开始输入文本
  - `A`: 从 光标的行 后面 开始输入文本
  - `i`: 从 光标 前面 开始输入文本
  - `I`: 从 光标的行 前面 开始输入文本
  - `o`: 在 光标的行 后面 插入一行
  - `O`: 在 光标的行 前面 插入一行

```
|命令| → a,A,i,I,o,O → |插入|
|模式| ←     ESC     ← |模式|
```

# 命令模式命令

- `:help`: 帮助
- `:q`: 退出 vi
- `:w <另存为>`: 保存
- `:w! <另存为>`: 保存（覆盖已有文件）
- `:wq`: 保存并退出
- `:q!`: 不保存并退出
- `:! <命令>`: 执行 Shell 命令
- `:r <文件名>`: 读和插入指定文件内容到当前光标位置（粘贴自）

## 命令模式快捷键

- `d`: 删除字( `w`ord ), 行( line )
- `u`: 撤销最后的编辑操作（重做）
- `y`: 复制(yank)
- `p`: 在当前行 后 粘贴已复制或删除的行
- `P`: 在当前行 前 粘贴已复制或删除的行
- `L`: →
- `H`: ←
- `J`: ↓
- `K`: ↑
- `0`: 回到本行开头

# 命令的格式

一般命令的按键语法如下：

- `[#1]operation [#2]target`

  - #1 是可选的数字，指定操作的次数
  - operation 指定操作
  - #2 是可选的数字，指定操作影响的目标数目
  - target 指定操作的目标

- 字(`word`)是空字符(空格、回车、换行)分割的字符串
  - `aaa bbb ccc`
- 如果当前字是操作的目标，输入 w word
- 如果当前行是操作的目标，目标的语法和操作的语法相同。

## 命令举例

- `dw`: 删除当前光标所在的字
  - `aaa bbb ccc` -> `bbb ccc`
  - `^          `
  - `aaa bbb ccc` -> `abbb ccc`
  - `^        `
- `d5w` / `5dw`: 删除 5 个字(`w`ord)，从当前光标位置开始
  - `aaa bbb ccc ddd eee fff` -> `fff`
  - `^                      `
  - `5dw`: 删除一个字，执行 5 次
  - `d5w`: 一次删除 5 个字，执行 1 次
  - `2d3w`: 删除 3 个字，执行 2 次，实际删除 6 个字 = `6dw` = `d6w`
- `dd`: 删除光标所在的 1 行（如果当前行是操作的目标，目标的语法和操作的语法相同）
- `2dd`: 删除 2 行，从当前行开始
  - `aaa` -> `ccc`
  - `bbb`
  - `ccc`
- `:2,3d`: 删除第 2-3 行
  - `aaa` -> `aaa`
  - `bbb` -> `ddd`
  - `ccc`
  - `ddd`
- `yy`: 复制当前行
- `1G`: 把光标移动到文件的第 1 行
  - `5G`: 把光标移动到文件的第 5 行
- `G`: 把光标移动到文件的第最后 1 行
- `dG`: 删除当前行和之后的所有行

# 查找和替换

## 查找

`/str`: 查找 str 字符串

1. 光标移动到 从哪开始找 的位置。
2. 直接输入 `/` （不是 `:/` ）
3. 输入查找关键字，例如 `/bbb`
4. 按 `n` 查找下一个

## 替换

`:[range]s/old_string/new_string[/option]`

- `range`: 指定搜索范围，如果忽略，那么指定当前行
- `s`: 指定替换命令
- `/`: 搜索定界符
- `old_string`: 将要被替换的文本
- `/`: 替换定界符
- `new_string`: 替换之后的新文本
- `/option`: 修饰符，g 表示全部(global)

### 替换命令举例

- `:s/john/jane/`: 把 john 替换为 jane，在当前行中，替换 1 次。
- `:s/john/jane/g`: 把 john 替换为 jane，在当前行中，全部替换。
- `:1,10s/john/jane/g`: 把 john 替换为 jane，在 1-10 行中，全部替换。
- `:1,$s/john/jane/g`: 把 john 替换为 jane，在整个文件中，全部替换。

# 设置 vi 环境

使用 `:set` 命令设置 vi 工作环境。

| 选项       | 缩写 | 功能       |
| ---------- | ---- | ---------- |
| autoindent | ai   | 自动缩进   |
| ignorecase | ic   | 忽略大小写 |
| number     | nu   | 行号       |
| showmode   | smd  | 显示模式   |
| warpmargin | wm   | 换行便捷   |
| tabstop    | ts   | 水平制表位 |

## 例子

- `:set nu`: 显示行号

## 设置 tab 键为 4 个空格：

```
set tabstop=4     表示一个 tab 显示出来是多少个空格的长度，默认 8。
set softtabstop=4 表示在编辑模式的时候按退格键的时候退回缩进的长度，当使用 expandtab时特别有用。
set shiftwidth=4  表示每一级缩进的长度，一般设置成跟 softtabstop 一样。
set expandtab     当设置成 expandtab 时，缩进用空格来表示，noexpandtab 则是用制表符表示一个缩进。
```

# vim 设置 持久设置

- 设置环境只对当前会话有效。
- 可以把环境设置保存在用户主目录的 `~/.exrc` 文件中，可单行可多行。
  - 单行： `set ts=4 nu ai`
  - 多行:

```
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set mouse=
set number
set noai
set nosi
```

## 其他

禁用鼠标操作（可视）： `set mouse=`

## LazyVim nvim 整合包 https://www.lazyvim.org/

```bash
apt install nvim -y

# Make a backup of your current Neovim files:

# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

# Clone the starter

git clone https://github.com/LazyVim/starter ~/.config/nvim

# Remove the .git folder, so you can add it to your own repo later

rm -rf ~/.config/nvim/.git

# Start Neovim!

nvim
```

## SpaceVim 整合包 https://spacevim.org/

curl -sLf https://spacevim.org/install.sh | bash

rm -rf ~/.SpaceVim.d && rm -rf ~/.vimrc && rm -rf ~/.config/nvim && rm -rf ~/.SpaceVim && rm -rf ~/.vim && curl -sLf https://spacevim.org/install.sh | bash

- h 向左移动光标
- j 向下移动光标
- k 向上移动光标
- l 向右移动光标
- <Up>,<Down> 智能上下
- H 将光标移动到屏幕顶部
- L 将光标移动到屏幕底部
- < 向左缩进并重新选择
- >     向右缩进并重新选择
- } 向前段落
- { 段落向后
- Ctrl-f// Shift-Down\_<PageDown> 平滑向前滚动
- Ctrl-b// Shift-Up\_<PageUp> 平滑向后滚动
- Ctrl-d 平滑向下滚动
- Ctrl-u 平滑向上滚动
- Ctrl-e 智能向下滚动 ( 3 Ctrl-e/j)
- Ctrl-y 智能向上滚动 ( 3Ctrl-y/k)
- Ctrl-a 将光标移至开头
- Ctrl-b 在命令行中向后移动光标
- Ctrl-f 在命令行中向前移动光标
- Ctrl-w 删除整个单词
- Ctrl-u 删除光标之前的所有文本
- Ctrl-k 删除光标后的所有文本
- Ctrl-c/Esc 取消命令行模式
- Tab 弹出菜单中的下一项
- Shift-Tab 弹出菜单中的上一项

https://spacevim.org/documentation/#command-line-mode-key-bindings
