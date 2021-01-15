# 神楽坂雅詩
$tmpfile = 'B:\opencc.txt'
Add-Type -Assembly PresentationCore
$clip = [System.Windows.Clipboard]
If(!$clip::ContainsText())
{
    Write-Warning '不支持的剪贴板数据格式'
    exit
}
$instr = $clip::GetText()
if ($instr.length -eq 0)
{
    Write-Warning '剪贴板中没有需要转换的内容'
    exit
}
$instr = $instr.Trim()
echo $instr | Out-File -Encoding utf8 $tmpfile
# https://github.com/BYVoid/OpenCC#%E9%A0%90%E8%A8%AD%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6
$mode = 's2twp'
if ($args[0]) {
    $mode = $args[0]
}
Set-Variable outstr (C:\OpenCC\build\bin\opencc.exe --config "C:\OpenCC\build\share\opencc\$mode.json" --input $tmpfile)
del $tmpfile
Write-Host $instr
if ($instr -eq $outstr)
{
    Write-Warning '转换之后的内容和之前一致'
    exit
}
Write-Host $($instr.Length.ToString() + ' -> ' + $mode + ' -> ' + $outstr.Length.ToString())
Write-Host $outstr
$clip::SetText($outstr)