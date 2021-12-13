1. 左侧 `Debug` 栏
2. 创建 `launch.json`
3. 弹出框选 `Node.js`
4. 编辑 `.vscode/launch.json`

- `npm run serve`:
```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [{
        "name": "Launch via NPM",
        "request": "launch",
        "runtimeArgs": [
            "run",
            "serve"
        ],
        "runtimeExecutable": "npm",
        "skipFiles": [
            "<node_internals>/**"
        ],
        "type": "node"
    }]
}
```

| 键盘快捷键              | 说明     |
| ----------------------- | -------- |
| `F5`                    | 启动调试 |
| `Ctrl` + `F5`           | 直接运行 |
| `Shift` + `F5`          | 终止调试 |
| `Ctrl` + `Shift` + `F5` | 重启调试 |