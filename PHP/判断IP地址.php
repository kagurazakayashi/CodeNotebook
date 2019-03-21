FILTER_FLAG_IPV4 - 要求值是合法的 IPv4 IP（比如 255.255.255.255）
FILTER_FLAG_IPV6 - 要求值是合法的 IPv6 IP（比如	2001:0db8:85a3:08d3:1319:8a2e:0370:7334）
FILTER_FLAG_NO_PRIV_RANGE - 要求值是 RFC 指定的私域 IP （比如 192.168.0.1）
FILTER_FLAG_NO_RES_RANGE - 要求值不在保留的 IP 范围内。该标志接受 IPV4 和 IPV6 值。

不需要正则表达式来判断，因为在php5.2.0之后，有专门的函数来做这个判断了。

判断是否是合法IP
<?php
if(filter_var($ip, FILTER_VALIDATE_IP)) {
// it's valid
}
else {
// it's not valid
}
?>

判断是否是合法的IPv4 IP地址
<?php
if(filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4)) {
// it's valid
}
else {
// it's not valid
}
?>

判断是否是合法的公共IPv4地址，192.168.1.1这类的私有IP地址将会排除在外
<?php
if(filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4 | FILTER_FLAG_NO_PRIV_RANGE)) {
// it's valid
}
else {
// it's not valid
}
?>

判断是否是合法的IPv6地址
<?php
if(filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_RES_RANGE)) {
// it's valid
}
else {
// it's not valid
}
?>

判断是否是public IPv4 IP或者是合法的Public IPv6 IP地址
<?php
if(filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE)) {
// it's valid
}
else {
// it's not valid
}
?>

<!-- http://www.w3school.com.cn/php/filter_validate_ip.asp -->
