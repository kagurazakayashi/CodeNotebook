业务流程
1、用户提交注册信息。
2、写入数据库，此时帐号状态未激活。
3、将用户名密码或其他标识字符加密构造成激活识别码（你也可以叫激活码）。
4、将构造好的激活识别码组成URL发送到用户提交的邮箱。
5、用户登录邮箱并点击URL，进行激活。
6、验证激活识别码，如果正确则激活帐号。
准备数据表
用户信息表中字段Email很重要，它可以用来验证用户、找回密码、甚至对网站方来说可以用来收集用户信息进行Email营销，以下是用户信息表t_user的表结构：

CREATE TABLE IF NOT EXISTS `t_user` ( 
  `id` int(11) NOT NULL AUTO_INCREMENT, 
  `username` varchar(30) NOT NULL COMMENT '用户名', 
  `password` varchar(32) NOT NULL COMMENT '密码', 
  `email` varchar(30) NOT NULL COMMENT '邮箱', 
  `token` varchar(50) NOT NULL COMMENT '帐号激活码', 
  `token_exptime` int(10) NOT NULL COMMENT '激活码有效期', 
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态,0-未激活,1-已激活', 
  `regtime` int(10) NOT NULL COMMENT '注册时间', 
  PRIMARY KEY (`id`) 
) ENGINE=MyISAM  DEFAULT CHARSET=utf8; 
HTML
在页面中放置一个注册表单，用户可以输入注册信息，包括用户名、密码和邮箱。
 
<form id="reg" action="register.php" method="post"> 
    <p>用户名：<input type="text" class="input" name="username" id="user"></p> 
    <p>密 码：<input type="password" class="input" name="password" id="pass"></p> 
    <p>E-mail：<input type="text" class="input" name="email" id="email"></p> 
    <p><input type="submit" class="btn" value="提交注册"></p> 
</form> 

对于用户的输入要进行必要的前端验证，关于表单验证功能，建议您参考本站文章：实例讲解表单验证插件Validation的应用，本文对前端验证代码略过，另外其实页面中还应该有个要求用户重复输入密码的输入框，一时偷懒就此略过。
register.php
用户将注册信息提交到register.php进行处理。register.php需要完成写入数据和发送邮件两大功能。
首先包含必要的两个文件，connect.php和smtp.class.php，这两个文件在外面提供的下载包里有，欢迎下载。
<?php
include_once("connect.php");//连接数据库 
include_once("smtp.class.php");//邮件发送类 
然后我们要过滤用户提交的信息，并验证用户名是否存在（前端也可以验证）。
 
$username = stripslashes(trim($_POST['username'])); 
$query = mysql_query("select id from t_user where username='$username'"); 
$num = mysql_num_rows($query); 
if($num==1){ 
    echo '用户名已存在，请换个其他的用户名'; 
    exit; 
} 
接着我们将用户密码加密，构造激活识别码：
 
$password = md5(trim($_POST['password'])); //加密密码 
$email = trim($_POST['email']); //邮箱 
$regtime = time(); 
 
$token = md5($username.$password.$regtime); //创建用于激活识别码 
$token_exptime = time()+60*60*24;//过期时间为24小时后 
 
$sql = "insert into `t_user` (`username`,`password`,`email`,`token`,`token_exptime`,`regtime`)  
values ('$username','$password','$email','$token','$token_exptime','$regtime')"; 
 
mysql_query($sql); 
上述代码中，$token即构造好的激活识别码，它是由用户名、密码和当前时间组成并md5加密得来的。$token_exptime用于设置激活链接URL的过期时间，用户在这个时间段内可以激活帐号，本例设置的是24小时内激活有效。最后将这些字段插入到数据表t_user中。
当数据插入成功后，调用邮件发送类将激活信息发送给用户注册的邮箱，注意将构造好的激活识别码组成一个完整的URL作为用户点击时的激活链接，以下是详细代码：
 
if(mysql_insert_id()){ 
    $smtpserver = ""; //SMTP服务器，如：smtp.163.com 
    $smtpserverport = 25; //SMTP服务器端口，一般为25 
    $smtpusermail = ""; //SMTP服务器的用户邮箱，如xxx@163.com 
    $smtpuser = ""; //SMTP服务器的用户帐号xxx@163.com 
    $smtppass = ""; //SMTP服务器的用户密码 
    $smtp = new Smtp($smtpserver, $smtpserverport, true, $smtpuser, $smtppass); //实例化邮件类 
    $emailtype = "HTML"; //信件类型，文本:text；网页：HTML 
    $smtpemailto = $email; //接收邮件方，本例为注册用户的Email 
    $smtpemailfrom = $smtpusermail; //发送邮件方，如xxx@163.com 
    $emailsubject = "用户帐号激活";//邮件标题 
    //邮件主体内容 
    $emailbody = "亲爱的".$username."：<br/>感谢您在我站注册了新帐号。<br/>请点击链接激活您的帐号。<br/> 
    <a href='http://www.helloweba.com/demo/register/active.php?verify=".$token."' target= 
'_blank'>http://www.helloweba.com/demo/register/active.php?verify=".$token."</a><br/> 
    如果以上链接无法点击，请将它复制到你的浏览器地址栏中进入访问，该链接24小时内有效。"; 
    //发送邮件 
    $rs = $smtp->sendmail($smtpemailto, $smtpemailfrom, $emailsubject, $emailbody, $emailtype); 
    if($rs==1){ 
        $msg = '恭喜您，注册成功！<br/>请登录到您的邮箱及时激活您的帐号！';     
    }else{ 
        $msg = $rs;     
    } 
} 
echo $msg; 
还有一个相当好用且强大的邮件发送类分享个大家：使用PHPMailer发送带附件并支持HTML内容的邮件，直接可以用哦。
active.php
如果不出意外，您注册帐号时填写的Email将收到一封helloweba发送的邮件，这个时候您直接点击激活链接，交由active.php处理。
active.php接收提交的链接信息，获取参数verify的值，即激活识别码。将它与数据表中的用户信息进行查询对比，如果有相应的数据集，判断是否过期，如果在有效期内则将对应的用户表中字段status设置1，即已激活，这样就完成了激活功能。
 
include_once("connect.php");//连接数据库 
 
$verify = stripslashes(trim($_GET['verify'])); 
$nowtime = time(); 
 
$query = mysql_query("select id,token_exptime from t_user where status='0' and  
`token`='$verify'"); 
$row = mysql_fetch_array($query); 
if($row){ 
    if($nowtime>$row['token_exptime']){ //24hour 
        $msg = '您的激活有效期已过，请登录您的帐号重新发送激活邮件.'; 
    }else{ 
        mysql_query("update t_user set status=1 where id=".$row['id']); 
        if(mysql_affected_rows($link)!=1) die(0); 
        $msg = '激活成功！'; 
    } 
}else{ 
    $msg = 'error.';     
} 
echo $msg;
?>

激活成功后，发现token字段并没有用处了，您可以清空。接下来我们会讲解用户找回密码的功能，也要用到邮箱验证，敬请关注。

来自 <http://www.helloweba.com/view-blog-228.html>
