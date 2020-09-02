chcp 65001
touch "B:\opencc.txt"
notepad "B:\opencc.txt"
"C:\OpenCC\build\bin\opencc.exe" --config "C:\OpenCC\build\share\opencc\s2twp.json" --input "B:\opencc.txt" --output "B:\opencc.txt"
CLIP < "B:\opencc.txt"
del "B:\opencc.txt"