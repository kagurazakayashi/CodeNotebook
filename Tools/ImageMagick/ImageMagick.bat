TITLE Windows 图片批处理

@REM 单行

for %x in (*.HEIC) do ("magick.exe" "%x" "%~nx.jpg")

@REM bat 用

setlocal enabledelayedexpansion
for %%x in (*.tif) do (
    "magick.exe" "%%x" -rotate 90 "%%~nx.bmp"
)

setlocal enabledelayedexpansion
for %%x in (*.ARW) do (
    "magick.exe" "%%x" "%%~nx.png"
)

@REM Windows PDF转图片

choco install ghostscript -y
mkdir out
magick.exe "a.pdf" "out\a.png"

@REM 将当前文件夹中所有透明背景的 TIFF 图片批量转换为 JPG 格式，并添加白色背景，设置 JPG 的质量为 100%
FOR %i in (*.tif) DO magick "%i" -background white -flatten -quality 100 "%~ni.jpg"
