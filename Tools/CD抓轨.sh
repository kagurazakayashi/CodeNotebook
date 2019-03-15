# “-1”表示将整张cd抓为一个文件否则一个音轨对应一个文件
# "-o flac"中的"-o"用于指定输出格式
# “-P”指定使用管道而不是临时的wav文件
# 其他常见的参数还有“-b”它大概是说平衡各个音轨的音量。
# 具体信息可以使用abcde --help查看。
# 它不提供指定输出位置的功能，默认将文件输出到当前目录下。如果使用了临时的wav文件，那么它会创建一个临时文件夹“abcde.xxxxxx”其中xxxxx表示一个随机数。对于最终输出，它会以“艺术家-专辑名”创建一个文件夹，然后在其中以“专辑名”/“音轨号-曲目名”保存各个文件。
abcde -1 -o flac

# 生成cue：
# mkcue默认输出信息到标准输出，需要重定向到文件。它只能提供最基本的音轨间隔信息，不包含歌手/曲目名等信息，需要手动编辑cue文件。
mkcue > output.cue

# 压缩为flac：
# -0~-8表示压缩级别，0最快，8最小。输出文件为同目录下的xxx.flac文件。
flac -8 xxx.wav

# https://blog.csdn.net/yanxiangtianji/article/details/24331553

# Windows
choco install flac eac -y