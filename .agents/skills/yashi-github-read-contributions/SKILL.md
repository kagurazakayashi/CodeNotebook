---
name: yashi-github-read-contributions
description: 讀取 GitHub 使用者的 contributions 熱力圖（貢獻日曆），分析活躍度，找出最早無貢獻日期、計算連續貢獻天數等。適用於任意 GitHub 使用者。
---
<!--
提问示例：
- 读取 https://github.com/kagurazakayashi 的 contributions 热力图，找出当前范围中最遥远的一次未提交日期，以 YYYY-MM-DD 格式显示。
  → 预期结果：返回如 `2026-04-12`，表示该用户在热力图范围内持续贡献至该日前一天，此日为范围内首个无贡献日。
- 分析 https://github.com/torvalds 的贡献热力图，告诉我他的连续提交天数。
- 读取我的 GitHub 贡献日历，找出最近一次无贡献的日期。
-->

# GitHub Contributions 熱力圖分析

## 前置條件

無需額外工具，僅使用內建 `webfetch` 即可完成。

---

## 工作流程

### 步驟 1：取得貢獻資料

使用 `webfetch` 存取 GitHub 使用者的 contributions 端點（純文字格式）：

```
https://github.com/users/{username}/contributions
```

`{username}` 為 GitHub 使用者名稱。使用 `format: "text"` 取得可解析的純文字內容。

> **注意**：直接存取 `https://github.com/{username}` 會返回大量 HTML 與 JavaScript，熱力圖資料透過 `include-fragment` 非同步載入，難以解析。務必使用上述 `/users/{username}/contributions` 端點。

### 步驟 2：解析資料結構

返回的文字內容以星期幾分組，結構如下：

```
N contributions in the last year
[月份清單：June, July, August, ...]

Sunday
  1 contribution on June 1st.
  1 contribution on June 8th.
  No contributions on April 12th.
  ...

Monday
  ...
```

每個星期幾（Sunday ~ Saturday）下方按時間順序列出該星期出現的每個日期，並標註貢獻數量或「No contributions」。

### 步驟 3：分析貢獻資料

根據使用者需求執行對應分析：

#### 3a. 找出最早的無貢獻日期

「最早」（亦稱「最遙遠」）指在熱力圖時間範圍內，從早到晚掃描時**第一個**出現 `No contributions on X` 的日期。

1. 按星期幾順序（Sunday → Saturday）逐行掃描
2. 從每個星期幾的清單中，依時間先後找出第一個 `No contributions on` 條目
3. 在各星期幾的結果中選出日期最早者（MM-DD 最小）
4. 根據熱力圖的年份範圍補足年份，輸出 `YYYY-MM-DD`

年份判斷規則：
- 熱力圖時間範圍約為過去一年（自當前日期向前推約 52 週）
- 若日期月份 ≤ 當前月份 → 年份 = 當前年份
- 若日期月份 > 當前月份（跨年）→ 年份 = 當前年份 − 1

#### 3b. 統計連續貢獻天數

1. 彙整所有日期及其貢獻數量（按時間排序）
2. 找出期間內最長連續貢獻天數（每日 ≥ 1 contribution）
3. 亦可計算總貢獻天數佔總天數比例

#### 3c. 依時間區段統計貢獻量

按月份、季度或自訂區間匯總貢獻數量。

---

## 關鍵注意事項

1. **使用正確的端點**：務必使用 `https://github.com/users/{username}/contributions`，勿直接擷取使用者 profile 頁面
2. **純文字格式**：`webfetch` 指定 `format: "text"`；Markdown 格式亦可使用，但純文字最利於解析
3. **日期範圍**：熱力圖覆蓋約 12 個月，起訖點隨當前日期變化
4. **月份名稱為英文**：返回結果中的月份使用英文全名（如 June、July），解析時需對照
5. **年份推斷**：返回內容中的日期不含年份（僅顯示月日，如「June 1st」），須根據當前日期與月份順序推斷
6. **跨年處理**：若熱力圖跨越兩個年份（如 June 2025 ~ June 2026），12 月後的日期屬於下一年
