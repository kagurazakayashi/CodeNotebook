#批量
for file in *.png; do echo "$file ${file%%.*}.bmp"; convert "$file" "${file%%.*}.bmp"; done
for file in *.bmp; do echo "$file ${file%%}.jpg"; convert "$file" "${file%%}.jpg"; done
for file in *.png; do echo "$file ${file%%}.jpg"; convert "$file" "${file%%}.jpg"; done
for file in *.tif; do echo $file ${file%%.*}.jpg; convert -resize 1024x1024 $file ${file%%.*}.jpg; done

convert fm.jpg -resize 1024x1024 -quality 80% fmz.jpg

# Windows
setlocal enabledelayedexpansion
for %%x in (*.png) do (
    "C:\Program Files\ImageMagick-7.0.8-Q16\magick.exe" "%%x" "%%x.bmp"
)

#将一个巨大图片拆分成一个一个小块：每512px一块
convert -crop 512x512 +repage product1024.png product_%d.jpg

#压缩比
-quality 80%
#旋转
convert -rotate 90 foo.png bar.png
#缩放
convert -resize 100x100 foo.jpg thumbnail.jpg
convert -resize 50%x50% foo.jpg thumbnail.jpg
mogrify -sample 80x60 *.jpg
#上下翻转
convert -flip foo.png bar.png
#左右翻转
convert -flop foo.png bar.png
#高斯模糊
convert -blur 80 foo.jpg foo.png
#毛玻璃
convert -spread 30 foo.png bar.png
#边框
convert -mattecolor "#000000" -frame 60x60 yourname.jpg rememberyou.png
convert -border 60x60 -bordercolor "#000000" yourname.jpg rememberyou.png
#加文字
convert -fill green -pointsize 40 -draw 'text 10,50 "charry.org"' foo.png bar.png
#反色
convert -negate foo.png bar.png
#单色
convert -monochrome foo.png bar.png
#加噪声
convert -noise 3 foo.png bar.png
#油画效果
convert -paint 4 foo.png bar.png
#炭笔效果
convert -charcoal 2 foo.png bar.png
#漩涡
convert -swirl 67 foo.png bar.png
#凸起
convert -raise 5x5 foo.png bar.png

#截取屏幕的任一矩形区域
import foo.png
#截取程序的窗口
import -pause 3 -frame foo.png
#截取一个倾斜的窗口
import -rotate 30 -pause 3 -frame foo.png
#截取整个屏幕
import -pause 3 -window root screen.png

#显示图片
display foo.png
display *.png
#幻灯片
display -delay 5 *
# 1. space(空格): 显示下一张图片
# 2. backspace(回删键):显示上一张图片
# 3. h: 水平翻转
# 4. v: 垂直翻转
# 5. /:顺时针旋转90度
# 6. \:逆时针旋转90度
# 7. >: 放大
# 8. <: 缩小
# 9. F7:模糊图片
# 10. Alt+s:把图片中间的像素旋转
# 11. Ctrl+s:图象另存
# 12. Ctrl+d:删除图片
# q: 退出

convert -resize "200x100>" src.jpg dest.jpg
# 注解：只有当src.jpg的宽大于200或高大于100时候，才进行缩小处理，
# 否则生成的dest.jpg和src.jpg具有一样的尺寸。
# 注意在linux下要用单引号替换成双引号，即'200x100>'。

convert -resize "200x100<" src.jpg dest.jpg
# 注解：只有当src.jpg的宽小于200或高小于100时候，才进行放大处理，
# 否则生成的dest.jpg和src.jpg具有一样的尺寸。
# 注意在linux下要用单引号替换成双引号，即'200x100<'
# 上述两种有条件缩放是按原始图等比例缩放的，也就是对符合条件的图片进行等比缩放。同时有条件缩放也可以与固定大小缩放联合起来用。例如如下命令。

convert -resize "800x100>!" src.jpg dest.jpg
# 注解：假设src.jpg尺寸是300x200。很显然src.jpg的高(200)是大于指定值高(100)，
# 符合缩小的条件，由于执行的不是等比缩放，
# 所以dest.jpg的尺寸理论上是800x100，由于执行是缩小操作
# 显然800是超过原始图片宽的，故dest.jpg的宽只能是300

convert -resize "10x1000<!" src.jpg dest.jpg
# 注解：假设src.jpg尺寸是300x200，src.jpg的高(200)小于指定值高(1000)，
# 因此该命令将执行放大图片操作，dest.jpg的高将放到到1000,
# 由于目标图片宽比原始图片还小，但是执行的是放大操作，因此只能用原始图片的宽，
# 所以得到的dest.jpg的尺寸是300x1000。
