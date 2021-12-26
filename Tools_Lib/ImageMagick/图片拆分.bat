@REM 长图四等分
magick a.jpg -crop 100%x25% a.jpg



magick chicken.png -crop 93x75+744+79 -rotate -90 -background none -gravity center -geometry +3+11 -extent 99x99 chicken_1_0.png

@REM 源图片文件：chicken.png
@REM -crop：裁剪。参数格式为： 宽x长{+-x}{+-y}。参数取frame值93x75+744，因为旋转-90度，所以，这里长和宽是对调的。
@REM -rotate：旋转，顺时针为正，逆时针为负。rotated为true所以旋转-90度
@REM -background：填充背景色，默认为白色，这里使用none不填充，png的话就是纯透明色
@REM -gravity：参照点，会影响通过geometry、annotate、region等来定义坐标点，center为中心点
@REM -geometry：移动，格式{+-x}{+-y}，将图片移动(x,y)个像素。取spriteSourceSize的(x、y)值国为旋转了-90度，所以x、y值对调(+3+11)
@REM -extent：填充，将图片填充到多大。宽x高。取sourceSize的w、h值（99x99）
@REM 最后输出文件：chicken_1_0.png

@REM https://www.jianshu.com/p/5f36a0c0d2ef