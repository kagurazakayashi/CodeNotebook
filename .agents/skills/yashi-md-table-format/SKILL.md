---
name: yashi-md-table-format
display_name: Markdown 表格格式化
description: >-
  格式化 Markdown 表格，按显示宽度对齐（全角字符占 2 格、半角字符占 1 格），
  保留每列左/右/居中对齐方式。适用于 .md 文件中的表格、代码文件注释中的表格文本、
  以及任何中英文混排需要工整对齐的表格。当需要"表格对齐""整理表格""格式化表格"
  "表格工整""让表格列宽一致"，或准备手工拼空格对齐表格时，调用本技能；
  禁止手工拼空格对齐表格。
---

# Markdown 表格格式化

将 Markdown 表格按显示宽度工整对齐，正确处理全角/半角混排，并保留各列对齐方式。

## 工具位置

- 脚本（随本技能分发，Git 版本管理）：`scripts/md_table_format.py`，与本 SKILL.md 同级；
  请按「本 SKILL.md 所在目录」拼路径，**不要假设当前工作目录**。
- 两处副本内容一致，任选其一：`~/.agents/skills/yashi-md-table-format/` 或本仓库 `.agents/skills/yashi-md-table-format/`。
- Python：直接用 PATH 里的 `python`；依赖无（仅标准库）。

## 调用方式

以下命令在**仓库根目录或用户主目录**下运行（两处都有 `.agents/skills/`，同样可用）；
也可 cd 进 `scripts/` 后用脚本名直接调用。

```bash
# 就地改写文件中的表格（最常用）
python .agents/skills/yashi-md-table-format/scripts/md_table_format.py -w 文件路径

# heredoc 管道粘贴表格 → 整理结果输出到 stdout（结束标记 EOF 须顶格）
python .agents/skills/yashi-md-table-format/scripts/md_table_format.py <<'EOF'
| 名称 | 版本 |
| --- | --- |
| Python | 3.12 |
EOF

# 文件内容输出到 stdout
python .agents/skills/yashi-md-table-format/scripts/md_table_format.py 文件路径
```

其它参数（详见脚本头部 docstring）：
- `-o 输出文件`：结果写入指定文件
- `--ambiguous-width 1`：模糊宽度字符（©·℃ 等）按半角 1 格处理

## 规则

1. 表格包含中文/全角字符时，**必须**调用本工具，禁止手工数空格对齐——全角占 2 格、
   半角占 1 格，人眼极易算错
2. 生成的 Markdown 表格（包括代码注释中的表格）先写好表格文本，再跑本工具格式化，
   以工具输出作为最终内容
3. 工具自动跳过围栏代码块内的表格、不误切转义竖线 `\|`、HTML 标签不计入宽度
4. 若脚本不存在或调用失败，退回手工对齐并向用户说明原因
