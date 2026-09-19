# opencode-project — OpenCode 專案管理 CLI

> 用於管理 OpenCode 追蹤的專案清單，版本 `1.17.2`

---

## 安裝

```bash
npm install -g opencode-project
```

### 已知問題

- `better-sqlite3` 的原生安裝腳本可能被 npm 的 `allow-scripts` 安全策略攔截，若安裝後執行報錯，需執行：
  ```bash
  npm install -g --allow-scripts=better-sqlite3
  ```

---

## 用法

```bash
opencode-project [選項] [命令]
```

---

## 選項

| 選項            | 簡寫 | 說明                           |
| --------------- | ---- | ------------------------------ |
| `--version`     | `-V` | 顯示版本號                     |
| `--data-path`   | `-d` | 指定 opencode 資料目錄或資料庫路徑 |
| `--verbose`     | `-v` | 啟用詳細輸出                   |
| `--help`        | `-h` | 顯示幫助資訊                   |

---

## 命令

### `list` / `ls`

列出所有已被 OpenCode 追蹤的專案。

```bash
opencode-project list
opencode-project ls
```

顯示欄位：`ID`、`Worktree`（工作目錄）、`Sessions`（會話數）、`Messages`（訊息數）、`Parts`（片段數）、`Todos`（待辦數）、`Diffs`（差異數）、`Snapshots`（快照數）、`Updated`（最後更新時間）。

### `remove` / `rm`

刪除指定專案及其關聯資料。

```bash
opencode-project remove <id...>
opencode-project rm <id...>
```

- 支援一次刪除多個專案（以空格分隔 ID）
- **警告：此操作不可逆，會清除該專案的所有會話與訊息記錄**

---

## 指定資料庫路徑

若 opencode 的資料目錄不在預設位置，可透過 `--data-path` 指定：

```bash
opencode-project list -d "C:\Users\yashi\.config\opencode"
opencode-project list -d "C:\Users\yashi\.config\opencode\opencode.db"
```
