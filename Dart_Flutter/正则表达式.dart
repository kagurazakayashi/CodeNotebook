if (RegExp(r"^[ZA-ZZa-z0-9.:]+$").hasMatch("string")) {
    print("OK");
}

// 忽略特殊字符
// r"^[\u4E00-\u9FA5A-Za-z0-9_]+$"

// 只能输入数字和小写字母
// r"^[Za-z0-9_]+$"

// 只能输入数字和字母
// r"^[ZA-ZZa-z0-9_]+$"

// 只能输入数字
WhitelistingTextInputFormatter.digitsOnly;

// 长度限制(限制6位)
LengthLimitingTextInputFormatter(6);

// 限制单行
BlacklistingTextInputFormatter.singleLineFormatter;

// 中国手机号
// r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$"

// 邮箱
// r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"

// URL
// r"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+"

// 中国身份证
// r"\d{17}[\d|x]|\d{15}"

// 中文
// r"[\u4e00-\u9fa5]"
