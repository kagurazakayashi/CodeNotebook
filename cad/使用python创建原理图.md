# 使用 Python(SKiDL) 创建电路原理图与制造文件

## 概述

本文档记录在 Windows 下使用 **SKiDL**（Python 电路描述库）+ **KiCad 10** 完成从代码到 PCB 工厂制造文件的全流程部署步骤。

核心思路：用 Python 代码描述电路 → 生成网表 → 生成 PCB → 自动布线 → 导出 Gerber/BOM/坐标 → 打包交工厂。

---

## 1. 所需软件

| 软件 | 版本 | 作用 | 安装方式 |
|---|---|---|---|
| Python | 3.11+（系统自带亦可） | 运行 SKiDL | python.org 下载，**勾选"Add to PATH"** |
| KiCad | 10.0 | 提供符号库、封装库、pcbnew 模块、kicad-cli | [kicad.org](https://www.kicad.org/) 下载 Windows 安装包，**完整安装** |
| freerouting | 2.2.4 | 自动布线（命令行模式） | [GitHub Release](https://github.com/freerouting/freerouting/releases/tag/v2.2.4) 下载 `freerouting-2.2.4-windows-x64.msi`，安装到默认路径 |

---

## 2. Python 库安装

### 2.1 给用户 Python 安装（仅需网表时）

```powershell
pip install skidl
```

`skidl` 用于用 Python 代码定义电路（符号、封装、网络连接）。

### 2.2 给 KiCad 自带 Python 安装（需要生成 PCB 时）

> 为什么用 KiCad 的 Python？因为 `pcbnew` 模块（KiCad 的 PCB 操作库）只存在于 KiCad 自带的 Python 里，用户自己装的 Python 没有。

```powershell
"C:\Program Files\KiCad\10.0\bin\python.exe" -m pip install --user skidl kinet2pcb
```

- `skidl`：电路定义与网表生成
- `kinet2pcb`：SKiDL 网表→KiCad PCB（**注意**：它对 KiCad 10 有兼容性问题，详见第 5 节）

---

## 3. 环境变量

以下环境变量让 SKiDL 和 kicad-cli 自动找到 KiCad 的符号库和封装库。

```powershell
setx KICAD9_SYMBOL_DIR "C:\Program Files\KiCad\10.0\share\kicad\symbols"
setx KICAD9_FOOTPRINT_DIR "C:\Program Files\KiCad\10.0\share\kicad\footprints"
```

| 变量 | 作用 | 谁在用 |
|---|---|---|
| `KICAD9_SYMBOL_DIR` | 符号库目录（含 `Device.kicad_sym`、`RF_Module.kicad_sym` 等） | SKiDL `Part()` 从这个目录加载符号 |
| `KICAD9_FOOTPRINT_DIR` | 封装库目录（含 `Resistor_SMD.pretty`、`RF_Module.pretty` 等子目录） | PCB 生成时从中加载封装文件 |

> **注意**：`setx` 设置的环境变量**只对新开的命令行窗口生效**，当前已开窗口不受影响。因此你的 Python 脚本里应该用 `os.environ.setdefault(...)` 作为兜底，确保任何环境都能跑。

---

## 4. KiCad 10 路径一览

| 路径 | 内容 |
|---|---|
| `C:\Program Files\KiCad\10.0\bin\kicad-cli.exe` | 命令行工具（导出 Gerber/钻孔/坐标等） |
| `C:\Program Files\KiCad\10.0\bin\pcbnew.exe` | PCB 编辑器 |
| `C:\Program Files\KiCad\10.0\bin\eeschema.exe` | 原理图编辑器 |
| `C:\Program Files\KiCad\10.0\bin\python.exe` | KiCad 自带的 Python（含 pcbnew 模块） |
| `C:\Program Files\KiCad\10.0\share\kicad\symbols\` | 符号库目录 |
| `C:\Program Files\KiCad\10.0\share\kicad\footprints\` | 封装库目录 |

---

## 5. 重要兼容性修补

### 5.1 kinet2pcb 对 KiCad 10 不兼容

`kinet2pcb` 1.1.4 在 Windows 上探测 KiCad 版本时仅查到 9.0，不包含 10.0，导致无法 `import pcbnew`。

**修复方法**：编辑 `kinet2pcb.py`（位于用户 Python 的 site-packages 或 KiCad 3rdparty 目录），将版本列表加上 `"10.0"`：

```python
# 修改前
for kicad_version in ("9.0", "8.0", "7.0", "6.0", "5.0"):

# 修改后
for kicad_version in ("10.0", "9.0", "8.0", "7.0", "6.0", "5.0"):
```

### 5.2 实际执行建议

即使修补了 kinet2pcb，它在 KiCad 10 上仍有封装加载 API 不兼容（`FootprintLoad` 在独立 Python 下 plugin 为空）。**生产级方案是绕过 kinet2pcb，直接用 pcbnew 原生 Python API 生成 PCB**，全部封装从 `.pretty` 目录路径直接加载。

---

## 6. 文件结构

```
B:\cad\
├── esp32_led_blink.py    ← SKiDL 电路定义（Part、Net、连接）
├── build_pcb.py          ← 从 SKiDL 电路生成 .kicad_pcb（含封装+布局+板框）
├── fabricate.py          ← 一键流水线（跑通全流程到工厂 ZIP）
├── esp32_led_blink.net   ← 网表文件（中间产物）
├── esp32_led_blink.dsn   ← Specctra 格式布线输入（中间产物）
├── esp32_led_blink.ses   ← Specctra 格式布线输出（中间产物）
├── esp32_led_blink.kicad_pcb  ← 已布线的 PCB 文件
├── esp32_led_blink_fab.zip    ← 工厂提交包（最终交付物）
└── gerber\               ← 解压后的制造文件
    ├── *-F_Cu.gtl        ← 顶层铜
    ├── *-B_Cu.gbl        ← 底层铜
    ├── *-F_Mask.gts      ← 顶层阻焊
    ├── *-B_Mask.gbs      ← 底层阻焊
    ├── *-F_Paste.gtp     ← 顶层锡膏钢网
    ├── *-B_Paste.gbp     ← 底层锡膏钢网
    ├── *-F_Silkscreen.gto ← 顶层白丝印
    ├── *-B_Silkscreen.gbo ← 底层白丝印
    ├── *-Edge_Cuts.gm1   ← 板框（外形裁切线）
    ├── *-job.gbrjob      ← Gerber 作业描述
    ├── *-PTH.drl         ← 镀通孔钻孔
    ├── *-NPTH.drl        ← 非镀通孔钻孔
    ├── pos.csv           ← 元件坐标（Pick-and-Place）
    └── bom.csv           ← 物料清单
```

---

## 7. 一键流水线命令

```powershell
"C:\Program Files\KiCad\10.0\bin\python.exe" B:\cad\fabricate.py
```

流程：
1. 建立 SKiDL 电路（网表）
2. 生成 PCB（封装 + 布局 + 板框）
3. 导出 Specctra DSN
4. freerouting 自动布线
5. 回灌布线结果（SES）到 PCB
6. kicad-cli 导出 Gerber / 钻孔 / 坐标
7. 生成 BOM
8. 打包为 ZIP

---

## 8. 注意事项

1. **必须用 KiCad 自带的 Python 运行**，用户自装的 Python 不含 `pcbnew` 模块
2. `setx` 设的环境变量**对新窗口**生效；建议脚本里始终 `os.environ.setdefault()` 兜底
3. **ESP32 模块是射频器件**，全自动布线不会处理天线净空区和地平面，**这种板子仅适合打样/验证流程，不能当量产品使用**
4. `esp32_led_blink.py` 内置防重入保护，多次调用 `build_circuit()` 不会重复创建元件
5. 如果 freerouting 安装到非默认路径，需修改 `fabricate.py` 中的 `FREEROUTING_EXE` 变量
6. BOM 中的 `LCSC` 列（采购料号）和 `Description` 列需人工填写
7. 元件的封装名必须与 KiCad 封装库中实际存在的名称一致（如 `RF_Module:ESP32-S3-WROOM-2` 而非旧版 `ESP32-S2-WROOM`）
