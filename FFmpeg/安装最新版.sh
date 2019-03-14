wget http://www.ffmpeg.org/releases/ffmpeg-3.1.tar.gz
tar -zxvf ffmpeg-3.1.tar.gz
cd ffmpeg-3.1
./configure --prefix=/usr/local/ffmpeg
make && make install

# 错误：operand type mismatch for `cmp'
# make: *** [libavcodec/x86/dsputil_mmx.o] 错误 1
# 将目录下~/ffmpeg/libavcodec/x86/h264_qpel_mmx.c的h264_qpel_mmx.c文件中的"g"替换为"rm"
# 使用vim，进入命令行模式，输入 :%s/"g"/"rm"/g 即可全部替换。