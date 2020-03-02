// 判断一个字符串中是否包含某一 子字符串
String str = "aaabbbccc";
int result = str.indexOf("bbb");
if(result != -1){
    System.out.println("包含: "+String.valueOf(result));
}else{
    System.out.println("不包含: "+String.valueOf(result));
}