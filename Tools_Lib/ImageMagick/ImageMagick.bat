# Windows 图片批处理

# 单行

for %x in (*.HEIC) do ("magick.exe" "%x" "%~nx.jpg")

# bat 用

setlocal enabledelayedexpansion
for %%x in (*.tif) do (
    "magick.exe" "%%x" -rotate 90 "%%~nx.bmp"
)

setlocal enabledelayedexpansion
for %%x in (*.ARW) do (
    "magick.exe" "%%x" "%%~nx.png"
)

# Windows PDF转图片

choco install ghostscript -y
mkdir out
magick.exe "a.pdf" "out\a.png"
