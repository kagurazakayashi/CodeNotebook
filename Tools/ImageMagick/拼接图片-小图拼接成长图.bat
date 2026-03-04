TITLE 拼接图片:小图拼接成长图

ECHO 横向拼接成一张横向长图:
magick part_00.png part_01.png part_02.png part_03.png +append output_horizontal.png

ECHO 自动按顺序批量:
magick part_*.png +append output_horizontal.png

ECHO 加间距:
magick part_*.png -bordercolor none -splice 20x0 +append output_horizontal.png

ECHO 纵向拼接:
magick part_*.png -append output_vertical.png
