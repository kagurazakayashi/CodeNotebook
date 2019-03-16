# 不保留小数
floatnumber.to_i

# 保留几位小数
format("%.2f",percentage).to_f

# 两位小数百分比
percentage = @savesize.to_f/@allsize.to_f*100
percentage = format("%.1f",percentage).to_f
puts "读取文件:#{File.basename(file_path)}，已写入:#{@savesize}，已完成:#{percentage}%"