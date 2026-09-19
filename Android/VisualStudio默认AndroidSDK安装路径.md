# VisualStudio 默认 AndroidSDK 安装路径: Visual Studio 2026 自带组件默认安装路径汇总（Android SDK / JDK / Node.js / Python）

本文档整理 **Visual Studio 2026** 安装 MAUI、Web、Python 工作负载时，自动捆绑的所有依赖组件默认安装路径，同时区分系统自带路径与第三方路径、必填/可选组件，解决路径查找、环境配置、冲突排查问题。

## 一、MAUI 安卓必备组件（勾选 Android SDK 自动安装）

安装 **NET MAUI 多平台应用 UI** 工作负载并勾选 Android 开发组件时，VS2026 会自动预装以下两个核心依赖，无需手动安装：

### 1 Android SDK

- **默认路径（C 盘）**：`C:\Program Files (x86)\Android\android-sdk`

- **自定义盘符路径**：若 VS 主体安装在 D 盘，会同步改为 `D:\Program Files (x86)\Android\android-sdk`

- **包含核心目录**：platform\-tools、build\-tools、cmdline\-tools、system\-images

- **关键区分**：此为 VS 专属 SDK，**不同于 Android Studio 默认路径**（`C:\Users\用户名\AppData\Local\Android\Sdk`），禁止混用

### 2 VS 自带 OpenJDK（Android 编译专用）

- **默认路径**：`C:\Program Files (x86)\Microsoft Visual Studio\Shared\Android\openjdk`

- **用途**：专属 MAUI 安卓项目编译，不影响系统其他 JDK 环境

### 3 Android 模拟器 AVD 镜像（特殊路径）

- **默认路径**：`C:\Users\你的用户名android\avd\`

- **说明**：虚拟机镜像、配置文件独立存放于用户目录，不在上述 SDK 根目录中

## 二、Nodejs（非 MAUI 必备，按需安装）

**重要说明**：仅安装 Android/MAUI 工作负载 **不会自带 Nodejs**，只有勾选 **ASPNET 和 Web 开发** 工作负载（勾选对应可选组件）才会自动安装。

- **默认路径（C 盘）**：`C:\Program Files\Microsoft Visual Studio\2026\Community\Web\NodeJs`

- **自定义盘符路径**：`D:\Program Files\Microsoft Visual Studio\2026\Community\Web\NodeJs`

- **说明**：该目录包含完整 nodeexe 运行时，仅 VS 开发环境默认调用

## 三、Python（非 MAUI 必备，按需安装）

**重要说明**：MAUI 安卓开发无需 Python，仅勾选 **Python 开发** 独立工作负载时，VS2026 会自动预装专属 Python 环境。

- **默认路径**：`C:\Program Files\Microsoft Visual Studio\Shared\Python311_64`

- **版本说明**：默认预装 Python311 64 位版本，版本号随 VS 迭代小幅变动

- **特点**：独立环境，不与系统手动安装的 Python 冲突

## 四、VS 内精准查看当前组件路径（最权威方式）

可直接在 Visual Studio 内查看生效的 SDK、JDK 路径，避免路径配置错误：

1. 打开 VS2026，点击顶部菜单栏 **工具\(Tools\) → 选项\(Options\)**

2. 依次展开 **NET MAUI → Android → SDKs**

3. 页面可直接查看：Android SDK Location、Java SDK Location 实时生效路径

## 五、命令行检测本地 Node/Python 环境

打开 CMD/PowerShell，执行以下命令，可一键查询电脑所有 Node、Python 安装路径，区分系统环境和 VS 专属环境：

```Plain Text
# 查看所有 Node.js 路径
where node

# 查看所有 Python 路径
where python
```

## 六、核心组件安装条件汇总表

| 组件        | 是否 MAUI 安卓必备 | 触发安装的工作负载            |
| ----------- | ------------------ | ----------------------------- |
| Android SDK | ✅ 必备            | NET MAUI（勾选 Android 组件） |
| VS OpenJDK  | ✅ 必备            | NET MAUI（勾选 Android 组件） |
| Nodejs      | ❌ 无需            | ASPNET 和 Web 开发            |
| Python      | ❌ 无需            | Python 开发                   |

## 七、补充避坑要点

- VS 自带组件均为**独立隔离环境**，不会覆盖系统手动安装的 JDK、Node、Python

- MAUI 编译安卓项目，强制优先使用 VS 自带的 Android SDK 和 OpenJDK，不建议手动替换第三方版本

- 若需全局使用 adb、node、python 命令，可手动将对应 VS 组件路径添加到系统环境变量

> （注：部分内容可能由 AI 生成）
