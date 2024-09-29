@echo off
TITLE 缩放和裁剪图片到 512x512 PNG
REM 使用 imagemagick 将当前文件夹中的所有 .jpg 文件图片尺寸的最小边改为 512px ，然后对多出 512px 的边，从开始处进行裁剪，最后得到一个 512x512 的 png 格式图片。
REM 检查当前文件夹中的所有 .jpg 文件
for %%i in (*.jpg) do (
    REM 如果输入的图片尺寸是 542x543，调整图片大小，使最小边为 512px，保持比例，最终得到的图片尺寸将是 511x512。所以为了之后裁剪 +1 为 513x513^
    magick "%%i" -resize 513x513^ "resized_%%~ni.png"
    
    REM 裁剪图片，使其变为 512x512 的正方形
    REM 这一步将裁剪图片以获得 512x512 的正方形图片。由于 -gravity center 选项被使用，裁剪将从图片的中心开始。
    REM 高度（513px）比目标高度（512px）多出 1px。由于从中心裁剪，图片的顶部和底部各会被裁剪 0.5px。裁剪后的图片尺寸将是 512x512。
    REM 裁剪后的图片将被保存为 input_512x512.png，最终得到的是一个 512x512 的 .png 文件。
    magick "resized_%%~ni.png" -gravity center -crop 512x512+0+0 +repage "%%~ni_512x512.png"
    
    REM 删除临时的 resized_ 文件
    del "resized_%%~ni.png"
)
echo 完成所有文件处理！
pause

REM =================================

for %%i in (*.jpg) do (
    magick "%%i" -resize 513x513^ "resized_%%~ni.png"
    magick "resized_%%~ni.png" -gravity center -crop 512x512+0+0 +repage "%%~ni_512x512.png"
    del "resized_%%~ni.png"
	del "%%i"
)

REM =================================

for %%i in (*.jpg) do (
    magick "%%i" -resize 512x512^ "%%~ni_512x512.png"
	del "%%i"
)
