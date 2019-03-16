puts "# 雅诗运维工具 SQL 监控文件解析"
puts "- 正在读入 SQL 监控文件 #{ARGV[0]} ..."
if !ARGV[0]
    puts "- 没有指定文件。"
    return 1
end
file = File.open(ARGV[0],"r:utf-8")
while line = file.gets
    puts line
end