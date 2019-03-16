def hello(a)
  puts a
end

hello(ARGV)

# 这时在命令行中输入：
# ruby -w test.rb "hello"
# 程序输出为：
# hello

# ARGV:参数数组