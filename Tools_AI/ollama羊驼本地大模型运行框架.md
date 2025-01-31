# [Ollama](https://ollama.com/)

「羊驼」家族
一个简明易用的本地大模型运行框架。
随着围绕着 Ollama 的生态走向前台，更多用户也可以方便地在自己电脑上玩转大模型了。

## WSL2 / Linux

`curl https://ollama.ai/install.sh | sh`

## 查询版本

`ollama --version`

## 用法
- 用法
    - ollama [标志]
    - ollama [命令]
- 可用命令
    - serve       启动 ollama
    - create      从 Modelfile 创建模型
    - show        显示模型的信息
    - run         运行一个模型
    - stop        停止正在运行的模型
    - pull        从注册表中拉取模型
    - push        将模型推送到注册表
    - list        列出模型
    - ps          列出正在运行的模型
    - cp          复制一个模型
    - rm          删除一个模型
    - help        有关任何命令的帮助
- Flags:
    - -h, --help      ollama 的帮助
    - -v, --version   显示版本信息

## 下载模型

- 模型列表: <https://ollama.com/models>
- 筛选模型: <https://huggingface.co/models?language=en,zh&sort=likes>
- 下载 qwen2.5 的 72b 模型: `ollama pull qwen2.5:72b`

## 运行模型

### 单条提问

`ollama run qwen2.5:72b "你好"`

### 交互模式

`ollama run qwen2.5:72b`

`>> /?`

- 可用命令：
    - /set 设置会话变量
    - /show 显示模型信息
    - /bye  退出
    - /?, /help 命令帮助
    - 使用 """ 开始多行消息。

`>> 你好`

### Web 版

[Ollama WebUI](https://github.com/ollama-webui/ollama-webui) 具有最接近 ChatGPT 的界面和最丰富的功能特性，需要以 Docker 部署

<!-- https://sspai.com/post/85193 -->
