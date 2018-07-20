首先，您可以到PHPMailer获取最新的下载包，解压到WEB目录下。
http://code.google.com/a/apache-extras.org/p/phpmailer/
然后建立一个sendmail.php的文件，载入PHPMailer类，并设置相关属性参数，如邮件服务器地址，发件人和收件人，邮件内容等等，详情请看代码：

<?php
require_once('class.phpmailer.php'); //载入PHPMailer类 
 
$mail = new PHPMailer(); //实例化 
$mail->IsSMTP(); // 启用SMTP 
$mail->Host = "smtp.163.com"; //SMTP服务器 以163邮箱为例子 
$mail->Port = 25;  //邮件发送端口 
$mail->SMTPAuth   = true;  //启用SMTP认证 
 
$mail->CharSet  = "UTF-8"; //字符集 
$mail->Encoding = "base64"; //编码方式 
 
$mail->Username = "helloweba@163.com";  //你的邮箱 
$mail->Password = "xxx";  //你的密码 
$mail->Subject = "你好"; //邮件标题 
 
$mail->From = "helloweba@163.com";  //发件人地址（也就是你的邮箱） 
$mail->FromName = "月光光";  //发件人姓名 
 
$address = "xyz@163.com";//收件人email 
$mail->AddAddress($address, "亲");//添加收件人（地址，昵称） 
 
$mail->AddAttachment('xx.xls','我的附件.xls'); // 添加附件,并指定名称 
$mail->IsHTML(true); //支持html格式内容 
$mail->AddEmbeddedImage("logo.jpg", "my-attach", "logo.jpg"); //设置邮件中的图片 
$mail->Body = '你好, <b>朋友</b>! <br/>这是一封来自<a href="http://www.helloweba.com"  
target="_blank">helloweba.com</a>的邮件！<br/> 
<img alt="helloweba" src="cid:my-attach">'; //邮件主体内容 
 
//发送 
if(!$mail->Send()) { 
  echo "Mailer Error: " . $mail->ErrorInfo; 
} else { 
  echo "Message sent!"; 
}
?>

从代码中可以看出，实例化PHPMailer后，我们指定使用SMTP方式来发邮件，设置SMTP邮件服务器，并启用SMTP认证，如果您的邮件服务器不需要认证，则设置$mail->SMTPAuth=false，并且不需要密码就可以发送。然后设置字符集和编码支持中文字符，注意原版的PHPMailer包对中文字符的支持不太理想，所以您可以下载helloweba示例中的改进包。然后设置发件人和收件人，添加附件。注意附件原名最好不要用中文，可以在AddAttachment()指定中文名称。然后设置邮件html内容，最后就是发送，流程一目了然，
如果发送成功，将会收到如下邮件：
http://www.helloweba.com/attachments/fck/mail.jpg

来自 <http://www.helloweba.com/view-blog-205.html>
