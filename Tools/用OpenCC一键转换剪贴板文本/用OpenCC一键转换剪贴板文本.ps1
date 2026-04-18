<#
.SYNOPSIS
使用 OpenCC 針對剪貼簿文字進行逐行轉換，並將結果回寫到剪貼簿。

.DESCRIPTION
此腳本會先從 Windows 剪貼簿讀取純文字內容，
再依照指定的 OpenCC 模式（預設為 s2twp）逐行送入 opencc.exe 進行轉換。
採用逐行處理的方式，可降低整段管線處理時在某些環境下的相容性問題，
也較容易保留空白行與原始段落結構。

另外，腳本也針對 PowerShell 主控台／無視窗背景執行的情境做了編碼與例外處理強化，
避免因 Console Handle 無效而中斷。

.PARAMETER mode
OpenCC 的轉換模式名稱。
若有從命令列傳入第一個參數，會覆寫預設值 's2twp'。

.EXAMPLE
%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File .\OpenCC.ps1

.EXAMPLE
powershell.exe -ExecutionPolicy Bypass -File .\OpenCC.ps1 t2s

.NOTES
神楽坂雅詩 - 逐行处理+兼容性增强版
#>

# 1. 核心編碼設定：
#    這會影響 PowerShell 透過管線傳遞給外部 EXE 時所使用的輸出編碼。
#    這裡強制使用 UTF-8，避免中文在 OpenCC 處理過程中出現亂碼。
$OutputEncoding = [System.Text.Encoding]::UTF8

# 2. 嘗試設定主控台輸出編碼：
#    若目前是在無視窗、背景工作或某些宿主環境下執行，
#    [Console] 可能沒有可用的輸出 Handle，這時會拋出例外。
#    因此這裡用 try/catch 包住，失敗時靜默略過即可。
try {
    # 設定目前 Console 的輸出編碼為 UTF-8，讓主控台顯示中文更穩定。
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
} catch {
    # 句柄無效時靜默跳過，不影響背景轉換
}

# 設定程式結束前要等待幾秒。
# 主要用途是讓使用者能看到輸出訊息，不會一執行完就立即關閉。
$sleepSeconds = 1

# 預設 OpenCC 轉換模式：
# s2twp 通常表示簡體轉繁體（台灣慣用詞彙）。
$mode = 's2twp'  # .\OpenCC.ps1 tw2sp
# s: Simplified（簡體）t: Traditional（繁體）tw: Taiwan（臺灣）hk: Hong Kong（香港）jp: Japanese（日語漢字）p: Phrases（慣用詞轉換，如：程式 $\rightarrow$ 程式）
# $mode 值,說明,適用場景
# s2t,Simplified to Traditional,簡體 → 繁體（標準繁體）
# t2s,Traditional to Simplified,繁體 → 簡體
# s2tw,簡體 → 臺灣繁體,只轉換字形，不轉換詞彙
# s2twp,簡體 → 臺灣繁體 (Phrases),最常用。轉換字形並修正臺灣常用詞彙
# tw2s,臺灣繁體 → 簡體,只轉換字形
# tw2sp,臺灣繁體 → 簡體 (Phrases),轉換字形並修正為大陸常用詞彙
# s2hk,簡體 → 香港繁體,轉換為香港字形標準
# hk2s,香港繁體 → 簡體,香港字形 → 大陸簡體
# t2tw,繁體（OpenCC標準） → 臺灣繁體字形
# t2hk,繁體（OpenCC標準） → 香港繁體字形
# tw2t,臺灣繁體字形 → 繁體（OpenCC標準）
# hk2t,香港繁體字形 → 繁體（OpenCC標準）
# t2jp,繁體（OpenCC標準） → 日語新字型（舊字型 → 新字型）
# jp2t,日語新字型 → 繁體（OpenCC標準）

# OpenCC 執行檔路徑。 https://github.com/BYVoid/OpenCC
$openccExe = "C:\OpenCC\bin\opencc.exe"

# OpenCC 設定檔資料夾路徑，後續會依 mode 組出對應的 json。
$configDir = "C:\OpenCC\share\opencc"

# 如果有傳入第一個命令列參數，則用它覆蓋預設模式。
# 例如：.\OpenCC.ps1 t2s
if ($args[0]) { $mode = $args[0] }

# 基礎檢查：
# 先確認 opencc.exe 是否存在，若不存在則直接報錯並結束。
if (!(Test-Path $openccExe)) { 
    Write-Error "找不到 opencc.exe"
    pause
    exit 
}

# 載入 PresentationCore 組件，因為後面會使用 WPF 的剪貼簿 API。
Add-Type -Assembly PresentationCore

# 取得 Clipboard 類別型別，方便後續以靜態方法呼叫。
$clip = [System.Windows.Clipboard]

# 檢查剪貼簿中是否包含文字內容。
# 若沒有文字可轉換，就提示後結束。
if (!$clip::ContainsText()) { 
    Write-Warning '剪贴板中没有文本内容'
    Start-Sleep -Seconds $sleepSeconds
    exit 
}

# 從剪貼簿取得原始文字。
$instr = $clip::GetText()

# 依照換行拆成陣列：
# 同時相容 CRLF（Windows）與 LF（Unix-like）換行格式。
$lines = $instr -split "\r?\n"

# 記錄總行數，後面進度顯示會用到。
$totalLines = $lines.Count

# 組出 OpenCC 設定檔完整路徑，例如：
# C:\OpenCC\share\opencc\s2twp.json
$configPath = Join-Path $configDir "$mode.json"

# 建立一個泛型字串清單，用來逐行收集轉換後的內容。
# 使用 List[string] 比反覆字串拼接更有效率。
$outArray = New-Object System.Collections.Generic.List[string]

# 在主控台顯示開始處理的提示訊息。
Write-Host "开始转换: $totalLines 行 (模式: $mode)" -ForegroundColor Cyan

# 逐行轉換邏輯
for ($i = 0; $i -lt $totalLines; $i++) {
    # 取出目前要處理的這一行文字。
    $currentLine = $lines[$i]

    # 計算目前進度百分比。
    # 這裡用目前索引 / 總行數，並四捨五入成整數。
    $percent = [math]::Round(($i / $totalLines) * 100)

    # 更新 PowerShell 進度條顯示。
    Write-Progress -Activity "OpenCC" -Status "$percent%" -PercentComplete $percent

    # 若當前行為空字串、空白或只有空白字元，
    # 則直接保留原樣，不送進 OpenCC。
    # 這樣可以避免空行被不必要地處理，也能保留原始版面結構。
    if ([string]::IsNullOrWhiteSpace($currentLine)) {
        $outArray.Add($currentLine)
    } else {
        # 將目前這一行透過管線送入 opencc.exe 處理，
        # 並指定對應的 config 檔案。
        $convertedLine = $currentLine | & $openccExe --config $configPath

        # 把轉換後的結果加入輸出陣列。
        $outArray.Add($convertedLine)
    }
}

# 所有行都處理完後，將進度條標示為完成。
Write-Progress -Activity "OpenCC" -Completed

# 重新組合結果：
# 這裡統一使用 CRLF 作為輸出換行格式，便於 Windows 剪貼簿與常見編輯器使用。
$outstr = $outArray -join "`r`n"

# --- 輸出結果並處理結束邏輯 ---
# 若轉換前後內容完全相同，代表 OpenCC 沒有產生實際變化，
# 則不覆蓋剪貼簿，避免造成不必要的寫入。
if ($instr -eq $outstr) {
    Write-Warning '内容无变化，未覆盖剪贴板'
} else {
    # 將轉換後的文字寫回剪貼簿。
    $clip::SetText($outstr)
    
    # 在控制台輸出轉換後的結果
    Write-Host "--- 转换结果预览 ---" -ForegroundColor Yellow
    Write-Host $outstr
    Write-Host "--------------------" -ForegroundColor Yellow
    
    # 提示使用者已成功完成轉換並覆蓋剪貼簿。
    Write-Host "转换成功并已复制到剪贴板！" -ForegroundColor Green
}

# 顯示程式即將自動結束的提示。
Write-Host "程序将在 $sleepSeconds 秒后自动关闭..." -ForegroundColor Gray

# 等待指定秒數後結束，方便使用者查看訊息。
Start-Sleep -Seconds $sleepSeconds

# 正常結束腳本。
exit