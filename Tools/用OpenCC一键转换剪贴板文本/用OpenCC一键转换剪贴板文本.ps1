# 神楽坂雅詩
# %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File .\OpenCC.ps1
$tempFilePath = 'B:\opencc.txt'
$sleepSeconds = 0
$mode = 's2twp' # 預設配置文件: https://github.com/BYVoid/OpenCC#%E9%A0%90%E8%A8%AD%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6
if ($args[0]) {
    $mode = $args[0]
}
C:\OpenCC\build\bin\opencc.exe --version
Add-Type -Assembly PresentationCore
$clip = [System.Windows.Clipboard]
If(!$clip::ContainsText())
{
    Write-Warning '不支持的剪贴板数据格式'
    Start-Sleep -Seconds $sleepSeconds
    exit
}
$instr = $clip::GetText()
if ($instr.length -eq 0)
{
    Write-Warning '剪贴板中没有需要转换的内容'
    Start-Sleep -Seconds $sleepSeconds
    exit
}
$instr = $instr.Trim()
echo $instr | Out-File -Encoding utf8 $tempFilePath
Set-Variable outstr (C:\OpenCC\build\bin\opencc.exe --config "C:\OpenCC\build\share\opencc\$mode.json" --input $tempFilePath)
del $tempFilePath
Write-Host $instr
if ($instr -eq $outstr)
{
    Write-Warning '转换之后的内容和之前一致'
    Start-Sleep -Seconds $sleepSeconds
    exit
}
Write-Host $($instr.Length.ToString() + ' -> ' + $mode + ' -> ' + $outstr.Length.ToString())
Write-Host $outstr
$clip::SetText($outstr)
Start-Sleep -Seconds $sleepSeconds
exit
