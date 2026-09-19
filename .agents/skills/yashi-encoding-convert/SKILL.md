---
name: yashi-encoding-convert
display_name: 文本编码转换
description: >-
  文本编码转换工具：读取任意编码的文件（ANSI/GBK、Big5、Shift-JIS、UTF-16 等），
  输出为 UTF-8（默认）或指定编码。适用于 AI 读取 ANSI/GBK 等非 UTF-8 文件时先转码，
  或用户需要以特定编码（如 GBK）保存/读取文件时。支持自动检测编码、管道输入输出、
  就地改写。当用户说"编码转换""ANSI 文件""GBK 编码""转成 UTF-8""读取乱码文件"
  "以 GBK 保存"或需要处理非 UTF-8 文本文件时，调用本技能。
---

# 文本编码转换

读取任意编码的文本文件，输出为指定编码（默认 UTF-8）。典型场景：AI 读取
ANSI(GBK) 文件前先转成 UTF-8；或将文本保存为 GBK/Big5 等编码供旧程序使用。

## 工具位置

- 脚本（随本技能分发，Git 版本管理）：`scripts/encoding_convert.py`，与本 SKILL.md 同级；
  请按「本 SKILL.md 所在目录」拼路径，**不要假设当前工作目录**。
- 两处副本内容一致，任选其一：`~/.agents/skills/yashi-encoding-convert/` 或本仓库 `.agents/skills/yashi-encoding-convert/`。
- Python：直接用 PATH 里的 `python`；依赖无（仅标准库 `codecs`）。

## 调用方式

以下命令在**仓库根目录或用户主目录**下运行（两处都有 `.agents/skills/`，同样可用）；
也可 cd 进 `scripts/` 后用脚本名直接调用。

```bash
# 读取 ANSI(GBK) 文件，输出 UTF-8 到 stdout（AI 最常用）
python .agents/skills/yashi-encoding-convert/scripts/encoding_convert.py 文件.txt

# 就地改写：将文件转成 UTF-8 保存（自动检测原编码）
python .agents/skills/yashi-encoding-convert/scripts/encoding_convert.py -w 文件.txt

# 指定输入编码（Big5/日文/韩文等 auto 检测不可靠时）
python .agents/skills/yashi-encoding-convert/scripts/encoding_convert.py -i big5 文件.txt
python .agents/skills/yashi-encoding-convert/scripts/encoding_convert.py -i shift_jis 文件.txt

# 输出为指定编码（如保存为 GBK 给旧程序）
python .agents/skills/yashi-encoding-convert/scripts/encoding_convert.py -e gbk -o 输出.txt 文件.txt
python .agents/skills/yashi-encoding-convert/scripts/encoding_convert.py -w -e gbk 文件.txt

# 管道：stdin 字节流 → stdout 字节流
cat 文件.txt | python .agents/skills/yashi-encoding-convert/scripts/encoding_convert.py

# 输出 UTF-8 带 BOM（Windows 记事本兼容）
python .agents/skills/yashi-encoding-convert/scripts/encoding_convert.py -e utf-8-sig -o 输出.txt 文件.txt
```

编码别名：`ansi/gbk/gb2312/cp936` → gb18030（Windows 中文 ANSI），`sjis` → shift_jis，`utf8` → utf-8。

## 自动检测说明（重要）

- auto 检测顺序：UTF-8(含BOM) → UTF-16/32(带BOM) → GB18030 → Big5 → Shift_JIS → EUC-KR → Latin-1
- **中文 GBK/GB2312（Windows ANSI）文件检测可靠**，直接 auto 即可
- **GB18030 能解码任意字节流**，会"抢走" Big5/日文/韩文文件导致乱码；检测时 stderr 会列出所有可解码候选，若结果乱码请用 `-i` 显式指定输入编码
- 日文 → `-i shift_jis` / `-i euc-jp`；韩文 → `-i euc-kr`；繁体 → `-i big5`

## 规则

1. 读取非 UTF-8 文件前，先用本工具转成 UTF-8 再读取；无法读取时提示用户可用本工具转码
2. 用户要求以特定编码保存文件时，用 `-e <编码> -o <文件>` 或 `-w -e <编码>`
3. `-w` 会改变文件本身的编码（默认转为 UTF-8），操作前告知用户
4. auto 检测结果若乱码（尤其 Big5/日文/韩文），改用 `-i` 显式指定输入编码
5. 若脚本不存在或调用失败，向用户说明原因
