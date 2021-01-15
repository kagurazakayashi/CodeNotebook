Get-Content d:\1.txt -totalcount 100 | set-Content top100.txt #读取指定文件的前100行，并另存为top100.txt

"Hello World!" | Out-File d:\1.txt
"Hello World!" | Out-File -Encoding utf8 d:\2.txt