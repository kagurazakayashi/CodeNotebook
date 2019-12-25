简单版：

<?php
header("Content-Type: text/html;charset=utf-8");

$str = '<div class="ui-block-a" align="center">
        <a href="online-39.html"><img class="lazy" width="131" height="177" src="http://www.smsyun.com/uploads/image/20140620/2014052010425.jpg"/>
        <h3>2014年</h3></a></div>';

$imgpreg = "/<img (.*?) src=\"(.+?)\".*?>/";
preg_match($imgpreg,$str,$img);
$mycount=count($img)-1;
 $imgval = $iim[$mycount];
if(!empty($imgval)){
    echo $imgval;
}else{
    echo 'no';
}
?>

详细版：

<?php
/*PHP正则提取图片img标记中的任意属性*/
$str = '<center><img src="/uploads/images/20100516000.jpg" height="120" width="120"><br />PHP正则提取或更改图片img标记中的任意属性</center>';

//1、取整个图片代码
preg_match('/<\s*img\s+[^>]*?src\s*=\s*(\'|\")(.*?)\\1[^>]*?\/?\s*>/i',$str,$match);
echo $match[0];

//2、取width
preg_match('/<img.+(width=\"?\d*\"?).+>/i',$str,$match);
echo $match[1];

//3、取height
preg_match('/<img.+(height=\"?\d*\"?).+>/i',$str,$match);
echo $match[1];

//4、取src
preg_match('/<img.+src=\"?(.+\.(jpg|gif|bmp|bnp|png))\"?.+>/i',$str,$match);
echo $match[1];

/*PHP正则替换图片img标记中的任意属性*/
//1、将src="/uploads/images/20100516000.jpg"替换为src="/uploads/uc/images/20100516000.jpg")
print preg_replace('/(<img.+src=\"?.+)(images\/)(.+\.(jpg|gif|bmp|bnp|png)\"?.+>)/i',"\${1}uc/images/\${3}",$str);
echo "<hr/>";

//2、将src="/uploads/images/20100516000.jpg"替换为src="/uploads/uc/images/20100516000.jpg",并省去宽和高
print preg_replace('/(<img).+(src=\"?.+)images\/(.+\.(jpg|gif|bmp|bnp|png)\"?).+>/i',"\${1} \${2}uc/images/\${3}>",$str);
?>
