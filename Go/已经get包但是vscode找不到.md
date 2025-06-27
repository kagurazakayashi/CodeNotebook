# 已经get包但是vscode找不到

- 使用 vscode 创建 golang package 时，import 了 "gopkg.in/yaml.v3" 。
- 使用 `go get "gopkg.in/yaml.v3"` 并 `go mod tidy` ，没有任何报错。
- 但是 vscode 仍然会标注红线并提示 `could not import gopkg.in/yaml.v3 (cannot find package "gopkg.in/yaml.v3" in GOROOT or GOPATH)` 。

## 看一下环境

`go env`

显示 `set GO111MODULE=` 的话是自动，可以改为强制启用。

## 使用 GO 环境变量

```bash
# 改为强制启用
go env -w GO111MODULE=on
go env GO111MODULE
# 应该输出：on
```

## 或使用 vscode 配置

```json
{
  "go.useLanguageServer": true,
  "go.toolsEnvVars": {
    "GO111MODULE": "on"
  }
}
```

## 再尝试安装

```bash
go get gopkg.in/yaml.v3@latest
go mod tidy
```
