puts "[雅诗运维工具] Nginx 日志文件解析"
puts "正在读入Nginx日志文件 #{ARGV[0]} ..."
file = File.open(ARGV[0],"r")
while line = file.gets
    nowinfos = Array.new
    tmpstr = "";
    tmping = false
    line.each_char{|nowchar|
        if nowchar == '[' or (nowchar == '"' and !tmping)
            tmping = true
        elsif nowchar == ']' or (nowchar == '"' and tmping) or (nowchar == ' ' and !tmping)
            tmping = false
            if tmpstr != ""
                nowinfos << tmpstr
                tmpstr = "";
            end
        else
            tmpstr += nowchar
        end
    }
    puts nowinfos
end