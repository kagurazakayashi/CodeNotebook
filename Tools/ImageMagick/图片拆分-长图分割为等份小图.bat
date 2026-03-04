TITLE 图片拆分:长图分割为等份小图

ECHO 将长图垂直分成四等份
magick long.png -crop 1x4@ +repage part_%02d.png
@REM 生成的文件：
@REM part_00.png
@REM part_01.png
@REM part_02.png
@REM part_03.png
@REM -crop 1x4@ 把图像按 1 列 × 4 行 均分
@REM +repage 移除裁切后残留的虚拟画布偏移
@REM part_%02d.png 输出文件编号，比如 00、01、02、03

ECHO 横图:
magick long.png -crop 4x1@ +repage part_%02d.png

ECHO 手动每段 600px 高:
magick long.png -crop x600 +repage part_%02d.png
