require 'find'
@outfile = "alltext.txt" #生成临时文件名
@filetype = ".log" #要搜索的扩展名
@mem = 1024*1024 #每次读入内存多少数据
@savesize = 0 #存储大小计数
@allsize = 0 #全部大小计数
@files = 0 #文件数量计数
puts "[雅诗运维工具] 合并日志文件"
puts "正在准备..."
begin
    File.delete(@outfile)
rescue => e
end
def pre_traverse_dir(file_path)
    if File.directory? file_path
        Dir.foreach(file_path) do |file|
            if file !="." and file !=".."
                pre_traverse_dir(file_path+"/"+file)
            end
        end
    elsif file_path.length > 4 and file_path[-4..-1] == @filetype
        nowsize = File.size(file_path)
        @allsize += nowsize
        @files += 1
    end
end
def traverse_dir(file_path)
    if File.directory? file_path
        Dir.foreach(file_path) do |file|
            if file !="." and file !=".."
                traverse_dir(file_path+"/"+file)
            end
        end
    elsif file_path.length > 4 and file_path[-4..-1] == @filetype
        nowsize = File.size(file_path)
        @savesize += nowsize
        percentage = @savesize.to_f/@allsize.to_f*100
        percentage = format("%.1f",percentage).to_f
        puts "读取文件:#{File.basename(file_path)}, 文件大小:#{nowsize}, 已写入:#{@savesize}, 已完成:#{percentage}%"
        rFile = File.new(file_path, "rb")
        wFile = File.new(@outfile, "ab")
        while true
            begin
                read_file = rFile.sysread(@mem)
                wFile.syswrite(read_file)
            rescue => e
                # puts e.message
                break
            end
        end
    end
end
pre_traverse_dir('.')
puts "总大小:#{@allsize}, 文件数量:#{@files}"
traverse_dir('.')
puts "完成。总大小:#{@allsize}, 文件数量:#{@files}, 实际写入:#{File.size(@outfile)}"