File.open('sample.pro') do |file|
    file.each do |line|
      puts line
    end
end

# 打印出字符串编码
File.open('sample.pro') do |file|
    file.each do |line|
      puts line.encoding
    end
end

# 指定编码
File.open('sample.pro','r:utf-8') do |file|
    file.each do |line|
      puts line
    end
end