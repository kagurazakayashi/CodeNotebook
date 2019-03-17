puts "# 雅诗运维工具 文件列表生成器"
@allfile = 0
@alldir = 0
@allsize = 0
def traverse_dir(file_path,f)
    if File.directory? file_path
        @alldir += 1
        begin
            Dir.foreach(file_path) do |file|
                if file !="." and file !=".."
                    traverse_dir(file_path+"/"+file,f)
                end
            end
        rescue
            puts "E:dir:#{file_path}"
        end
    else
        @allfile += 1
        basename = "(null)"
        size = -1
        begin
            basename = File.basename(file_path)
        rescue
            puts "E:basename:#{file_path}"
        end
        begin
            size = File.size(file_path)
            @allsize += size
        rescue
            puts "E:size:#{file_path}"
        end
        f.puts "#{basename},#{size},#{file_path}"
        if (@allfile % 1000 == 0)
            puts "allfile=#{@allfile}, alldir=#{@alldir}, allsize=#{@allsize}"
        end
    end
end
File.open("B:/allfiles.csv","a+:utf-8") do |f|
    traverse_dir('.',f)
end
puts "allfile=#{@allfile}, alldir=#{@alldir}, allsize=#{@allsize}"
