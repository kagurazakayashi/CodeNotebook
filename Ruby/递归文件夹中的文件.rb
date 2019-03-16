# 递归
def traverse_dir(file_path)
    if File.directory? file_path
        Dir.foreach(file_path) do |file|
            if file !="." and file !=".."
                traverse_dir(file_path+"/"+file)
            end
        end
    else
        puts "File:#{File.basename(file_path)}, Size:#{File.size(file_path)}"
    end
end


# 简化方法
require 'find'

Find.find('/Users/happy') do |path|
    puts path
end