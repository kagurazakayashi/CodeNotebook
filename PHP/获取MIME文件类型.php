<?php
$mime_type = mime_content_type('1.jpg'); 
echo $mime_type;
?>

//以上已弃用
//以下使用自带插件 extension=fileinfo

<?php
$fi = new finfo(FILEINFO_MIME_TYPE); 
$mime_type = $fi->file('1.jpg'); 
echo $mime_type; // image/jpeg 
?>