chcp 65001
SET openccBuild=C:\OpenCC\build
SET tempFilePath=B:\opencc.txt
ECHO. >"%tempFilePath%"
notepad "%tempFilePath%"
"%openccBuild%\bin\opencc.exe" --version
"%openccBuild%\bin\opencc.exe" --config "%openccBuild%\share\opencc\s2twp.json" --input "%tempFilePath%" --output "%tempFilePath%"
CLIP < "%tempFilePath%"
DEL "%tempFilePath%"
SET openccBuild=
SET tempFilePath=
