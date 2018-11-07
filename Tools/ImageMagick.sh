#批量
for file in *.png; do echo "$file ${file%%.*}.bmp"; convert "$file" "${file%%.*}.bmp"; done
for file in *.tif; do echo $file ${file%%.*}.jpg; convert -resize 1024x1024 $file ${file%%.*}.jpg; done

#缩放
convert -resize 100x100 foo.jpg thumbnail.jpg
convert -resize 50%x50% foo.jpg thumbnail.jpg
mogrify -sample 80x60 *.jpg
#旋转
convert -rotate 90 foo.png bar.png
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
