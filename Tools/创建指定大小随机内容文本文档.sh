# 1457664 1
pwgen -s 1457664 1 | tr -s '\n' | awk '{printf $0}' | iconv -f UTF-8 -t MS-ANSI >1457664.log

# FORMAT A 64KB*1024=65536B = 1441792 / 65536 = 22
dirName="0"
for i in `seq 1 22`
do
   filename=`echo $i | awk '{printf("%02d\n",$filename)}'`
   tofile=$filename.log
   echo $tofile
   pwgen -s 65536 1 | tr -s '\n' | awk '{printf $0}' | iconv -f UTF-8 -t MS-ANSI >$tofile
done

# FORMAT A 512B = 1457664 / 512 = 2847
j=512
dirName="0"
for i in `seq 1 2847`
do
   j=`expr $j + 1`
   if [ $j -gt 512 ];then
       j=1
       dirName=`expr $i - 1 | awk '{printf("%04d\n",$filename)}'`
       mkdir $dirName
   fi
   filename=`echo $i | awk '{printf("%04d\n",$filename)}'`
   tofile=$dirName/$filename.log
   echo $tofile
   pwgen -s 512 1 | tr -s '\n' | awk '{printf $0}' | iconv -f UTF-8 -t MS-ANSI >$tofile
done