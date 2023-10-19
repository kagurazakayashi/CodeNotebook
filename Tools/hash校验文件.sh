# hash校验文件
openssl sha256 *.vhd

# 校验结果另存为
# Linux Bash
for f in *.vhd.xz; do openssl sha256 $f >$f.txt; done
# Windows BAT
for %f in (*.vhd) do ( openssl sha256 %f >%f.txt )

# hash校验压缩包里的文件
# Linux Bash
for f in *.vhd.xz; do xz -d $f -c | openssl sha256 >$f.txt; done
# Windows BAT
for %f in (*.vhd) do ( xz -d %f -c | openssl sha256 %f >%f.txt )

# 输出结果
# Linux Bash
cat *.vhd.txt
# Windows BAT
TYPE *.vhd.txt
