wget -c -r -np -k -L -p http://www.baidu.com
# -c, –continue 接着下载没下载完的文件
# -r, –recursive 递归下载
# -np, –no-parent 不要追溯到父目录
# -k, –convert-links 转换非相对链接为相对链接
# -L, –relative 仅仅跟踪相对链接
# -p, –page-requisites 下载显示HTML文件的所有图片