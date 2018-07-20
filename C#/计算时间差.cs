// 问题:
startTime = DateTime.Now;            
-----------
slExecutedTime.Text = (DateTime.Now - startTime).ToString();
// 执行结果：
// 已执行：00:00:03.1234434（后面会多出很多的小数位）
// 想要的执行结果：
// 已执行：00:00:03

/*
解决方案一（推荐）：
TimeSpan的相关属性：

相关属性和函数
Add：与另一个TimeSpan值相加。
Days:返回用天数计算的TimeSpan值。
Duration:获取TimeSpan的绝对值。
Hours:返回用小时计算的TimeSpan值
Milliseconds:返回用毫秒计算的TimeSpan值。
Minutes:返回用分钟计算的TimeSpan值。
Negate:返回当前实例的相反数。
Seconds:返回用秒计算的TimeSpan值。
Subtract:从中减去另一个TimeSpan值。
Ticks:返回TimeSpan值的tick数。
TotalDays:返回TimeSpan值表示的天数。
TotalHours:返回TimeSpan值表示的小时数。
TotalMilliseconds:返回TimeSpan值表示的毫秒数。
TotalMinutes:返回TimeSpan值表示的分钟数。
TotalSeconds:返回TimeSpan值表示的秒数。
*/
 /// <summary>
        /// 程序执行时间测试
        /// </summary>
        /// <param name="dateBegin">开始时间</param>
        /// <param name="dateEnd">结束时间</param>
        /// <returns>返回(秒)单位，比如: 0.00239秒</returns>
        public static string ExecDateDiff(DateTime dateBegin, DateTime dateEnd)
        {
            TimeSpan ts1 = new TimeSpan(dateBegin.Ticks);
            TimeSpan ts2 = new TimeSpan(dateEnd.Ticks);
            TimeSpan ts3 = ts1.Subtract(ts2).Duration();
            //你想转的格式
            return ts3.TotalMilliseconds.ToString();
        }
/*
这是最基本的，得到的是毫秒数
如果你是只单纯的需要你的那种格式完全可以直接取前10位就行了
1. ts3.ToString("g")   0:00:07.171
ts3.ToString("c")   00:00:07.1710000
ts3.ToString("G")   0:00:00:07.1710000
有三种格式可以选择，我建议如果需要其实一种的时候可以使用截取的试比较快捷
比如
ts3.ToString("g").Substring(0,8)   0:00:07.1
ts3.ToString("c").Substring(0,8)   00:00:07
ts3.ToString("G").Substring(0,8)   0:00:00
*/

方案二：较繁琐

#region 返回时间差
        public static string DateDiff(DateTime DateTime1, DateTime DateTime2)
        {
            string dateDiff = null;
            try
            {
                TimeSpan ts1 = new TimeSpan(DateTime1.Ticks);
                TimeSpan ts2 = new TimeSpan(DateTime2.Ticks);
                TimeSpan ts = ts1.Subtract(ts2).Duration();
                string hours = ts.Hours.ToString(), minutes = ts.Minutes.ToString(),seconds = ts.Seconds.ToString();
                if(ts.Hours<10)
                {
                    hours = "0" + ts.Hours.ToString();
                }
                if (ts.Minutes<10)
                {
                    minutes = "0" + ts.Minutes.ToString();
                }
                if(ts.Seconds<10)
                {
                    seconds = "0" + ts.Seconds.ToString();
                }
                dateDiff = hours + ":"+ minutes + ":"+ seconds;
            }
            catch
            {
}
            return dateDiff;
        }
        #endregion

// 原创文章，转载请注明出处：http://www.cnblogs.com/hongfei/archive/2013/03/11/2953366.html

// From <http://www.cnblogs.com/hongfei/archive/2013/03/11/2953366.html>




// C#里面比较时间大小三种方法
DateTime   t1   =   new   DateTime(100);   
  DateTime   t2   =   new   DateTime(20);   
    
  if   (DateTime.Compare(t1,   t2)   >     0)   Console.WriteLine("t1   >   t2");     
  if   (DateTime.Compare(t1,   t2)   ==   0)   Console.WriteLine("t1   ==   t2");     
  if   (DateTime.Compare(t1,   t2)   <     0)   Console.WriteLine("t1   <   t2");   
 
 
 
// 1。比较时间大小的实验
string st1="12:13";
string st2="14:14";
DateTime dt1=Convert.ToDateTime(st1);
DateTime dt2=Convert.ToDateTime(st2);
DateTime dt3=DateTime.Now;
if(DateTime.Compare(dt1,dt2)>0)
msg.Text=st1+">"+st2;
else
msg.Text=st1+"<"+st2;
msg.Text+="\r\n"+dt1.ToString();
if(DateTime.Compare(dt1,dt3)>0)
msg.Text+="\r\n"+st1+">"+dt3.ToString();
else
msg.Text+="\r\n"+st1+"<"+dt3.ToString();

// 2。计算两个时间差值的函数，返回时间差的绝对值：
private string DateDiff(DateTime DateTime1,DateTime DateTime2)
{
string dateDiff=null;
try
{
TimeSpan ts1=new TimeSpan(DateTime1.Ticks);
TimeSpan ts2=new TimeSpan(DateTime2.Ticks);
TimeSpan ts=ts1.Subtract(ts2).Duration();
dateDiff=ts.Days.ToString()+"天"
+ts.Hours.ToString()+"小时"
+ts.Minutes.ToString()+"分钟"
+ts.Seconds.ToString()+"秒";
}
catch
{
}
return dateDiff;
}

// 3。实现计算DateTime1－36天＝DateTime2的功能
TimeSpan ts=new TimeSpan(40,0,0,0);
DateTime dt2=DateTime.Now.Subtract(ts);
msg.Text=DateTime.Now.ToString()+"-"+ts.Days.ToString()+"天\r\n";
msg.Text+=dt2.ToString();
 
 
use "DateTime.Compare" static method
DateTime.Compare( dt1, dt2 ) > 0 : dt1 > dt2
DateTime.Compare( dt1, dt2 ) == 0 : dt1 == dt2
DateTime.Compare( dt1, dt2 ) < 0 : dt1 < dt2
        /// <summary>
         /// 计算两个日期的时间间隔
         /// </summary>
         /// <param name="DateTime1">第一个日期和时间</param>
         /// <param name="DateTime2">第二个日期和时间</param>
         /// <returns></returns>
         private string DateDiff(DateTime DateTime1, DateTime DateTime2)
         {
             string dateDiff = null;
           
             TimeSpan ts1 = new TimeSpan(DateTime1.Ticks);
             TimeSpan ts2 = new TimeSpan(DateTime2.Ticks);
             TimeSpan ts = ts1.Subtract(ts2).Duration();
             dateDiff = ts.Days.ToString()+"天"
                 + ts.Hours.ToString()+"小时"
                 + ts.Minutes.ToString()+"分钟"
                 + ts.Seconds.ToString()+"秒";
           
             return dateDiff;
         }
/* 说明：
1.DateTime值类型代表了一个从公元0001年1月1日0点0分0秒到公元9999年12月31日23点59分59秒之间的具体日期时刻。因此，你可以用DateTime值类型来描述任何在想象范围之内的时间。一个DateTime值代表了一个具体的时刻
2.TimeSpan值包含了许多属性与方法，用于访问或处理一个TimeSpan值
下面的列表涵盖了其中的一部分：
Add：与另一个TimeSpan值相加。
Days:返回用天数计算的TimeSpan值。
Duration:获取TimeSpan的绝对值。
Hours:返回用小时计算的TimeSpan值
Milliseconds:返回用毫秒计算的TimeSpan值。
Minutes:返回用分钟计算的TimeSpan值。
Negate:返回当前实例的相反数。
Seconds:返回用秒计算的TimeSpan值。
Subtract:从中减去另一个TimeSpan值。
Ticks:返回TimeSpan值的tick数。
TotalDays:返回TimeSpan值表示的天数。
TotalHours:返回TimeSpan值表示的小时数。
TotalMilliseconds:返回TimeSpan值表示的毫秒数。
TotalMinutes:返回TimeSpan值表示的分钟数。
TotalSeconds:返回TimeSpan值表示的秒数。
*/
    int jg=72;//设置一个增加的时间
    DateTime dt=Convert.ToDateTime("2006-4-23 12:22:05");// 设置一个初始化的时间
    DateTime newdt=dt.AddHours(jg);//初始化时间加上增加的时间
    DateTime nowt=DateTime.Now;//现在的时间
    Response.Write("现在时间是："+nowt+"<br>");
    Response.Write("数据库时间是："+dt+"<br>");
    Response.Write("新的时间是："+newdt+"<br>");
    if(newdt<nowt)//如果相加后的时间大于现在的时间
    {
     Response.Write("可以");
    }
    else//否则
    {
     Response.Write("不行");
    }

// 得到某年某月的天数
   public static int GetDaysInMonth(int rYear,int rMonth)
   {
    DateTime dt1 = DateTime.Parse(rYear+"-"+rMonth+"-01");
    DateTime dt2 = dt1.AddMonths(1);
    TimeSpan ts = dt2-dt1;
    return (int)ts.TotalDays;
   }
//得到星期Text
   public static string GetDayOfWeekHtml(int rDayOfWeek)
   {
    switch(rDayOfWeek)
    {
     case (int)DayOfWeek.Sunday:
      return "<font color=\"#ff0000\">星期日</font>";
     case (int)DayOfWeek.Monday:
      return "<font color=\"#000000\">星期一</font>";
     case (int)DayOfWeek.Tuesday:
      return "<font color=\"#000000\">星期二</font>";
     case (int)DayOfWeek.Wednesday:
      return "<font color=\"#000000\">星期三</font>";
     case (int)DayOfWeek.Thursday:
      return "<font color=\"#000000\">星期四</font>";
     case (int)DayOfWeek.Friday:
      return "<font color=\"#000000\">星期五</font>";
     case (int)DayOfWeek.Saturday:
      return "<font color=\"#008800\">星期六</font>";
     default:
      return "";
    }
   }
//   得到某年某月的起止日期，格式为0000-00-00
   public static string[] GetBeginEndDate(int rYear,int rMonth)
   {
    string[] arr = new string[2];
    DateTime dt1 = DateTime.Parse(rYear+"-"+rMonth+"-01");
    arr[0] = dt1.ToLongDateString();
    DateTime dt2 = dt1.AddMonths(1).AddDays(-1);
    arr[1] = dt2.ToLongDateString();
    return arr;
   }

// 在ASP中日期比较使用：DateDiff( "d", "2006-1-30", now )>0;在C#中使用:TimeSpan
// 代码如下：
using System;
using System.Collections;
public class DatediffClass
{
public static void Main()
{
   DateTime dt1 = DateTime.Parse("2006-04-01");
   DateTime dt2 = DateTime.Parse("2006-05-01");
   TimeSpan ts = dt2.Subtract(dt1);
   Console.WriteLine(ts.TotalDays);
   Console.ReadLine();
}
}
// 如果是比较大小：
DateTime.Compare(t1, t2) >   0
// ====================
// 1、DateTime 数字型
System.DateTime currentTime=new System.DateTime();
// 1.1 取当前年月日时分秒
currentTime=System.DateTime.Now;
// 1.2 取当前年
int 年=currentTime.Year;
// 1.3 取当前月
int 月=currentTime.Month;
// 1.4 取当前日
int 日=currentTime.Day;
// 1.5 取当前时
int 时=currentTime.Hour;
// 1.6 取当前分
int 分=currentTime.Minute;
// 1.7 取当前秒
int 秒=currentTime.Second;
// 1.8 取当前毫秒
int 毫秒=currentTime.Millisecond;
// （变量可用中文）
// 2、
Int32.Parse(变量) Int32.Parse("常量")
// 字符型转换 转为32位数字型
// 3、
变量.ToString()
// 字符型转换 转为字符串
12345.ToString("n"); //生成 12,345.00
12345.ToString("C"); //生成 ￥12,345.00
12345.ToString("e"); //生成 1.234500e+004
12345.ToString("f4"); //生成 12345.0000
12345.ToString("x"); //生成 3039 (16进制)
12345.ToString("p"); //生成 1,234,500.00%

// 4、变量.Length 数字型
// 取字串长度：
// 如：
string str="中国";
int Len = str.Length ; //Len是自定义变量， str是求测的字串的变量名
// 5、
System.Text.Encoding.Default.GetBytes(变量)
// 字码转换 转为比特码
// 如：
byte[] bytStr = System.Text.Encoding.Default.GetBytes(str);
// 然后可得到比特长度：
len = bytStr.Length;
// 6、
System.Text.StringBuilder("")
// 字符串相加，（+号是不是也一样？）
// 如：
System.Text.StringBuilder sb = new System.Text.StringBuilder("");
sb.Append("中华");
sb.Append("人民");
sb.Append("共和国");
// 7、
变量.Substring(参数1,参数2);
// 截取字串的一部分，参数1为左起始位数，参数2为截取几位。
如：
string s1 = str.Substring(0,2);
// 8、
String user_IP=Request.ServerVariables["REMOTE_ADDR"].ToString();
// 取远程用户IP地址
// 9、穿过代理服务器取远程用户真实IP地址：
if(Request.ServerVariables["HTTP_VIA"]!=null){
string user_IP=Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
}else{
string user_IP=Request.ServerVariables["REMOTE_ADDR"].ToString();
}
// 10、
Session["变量"];
// 存取Session值；
// 如，赋值：
Session["username"]="小布什";
// 取值：
Object objName=Session["username"];
String strName=objName.ToString();
// 清空：
Session.RemoveAll();
// 11、
String str=Request.QueryString["变量"];
// 用超链接传送变量。
// 如在任一页中建超链接:<a href=Edit.aspx?fbid=23>点击</a>
// 在Edit.aspx页中取值：
String str=Request.QueryString["fdid"];
// 12、
DOC对象.CreateElement("新建节点名");
// 创建XML文档新节点
// 13、
父节点.AppendChild(子节点)；
// 将新建的子节点加到XML文档父节点下
// 14、
父节点.RemoveChild(节点);
// 删除节点
// 15、Response
Response.Write("字串")；
Response.Write(变量)；
// 向页面输出。
Response.Redirect("URL地址"）；
// 跳转到URL指定的页面
// 16、
char.IsWhiteSpce(字串变量，位数) //——逻辑型
// 查指定位置是否空字符；
// 如：
string str="中国 人民";
Response.Write(char.IsWhiteSpace(str,2)); //结果为：True, 第一个字符是0位，2是第三个字符。
// 17、
char.IsPunctuation('字符') //--逻辑型
// 查字符是否是标点符号
// 如：
Response.Write(char.IsPunctuation('A')); //返回：False
// 18、
(int)'字符'
// 把字符转为数字，查代码点，注意是单引号。
// 如：
Response.Write((int)'中'); //结果为中字的代码：20013
// 19、
(char)代码
// 把数字转为字符，查代码代表的字符。
// 如：
Response.Write((char)22269); //返回“国”字

// From <http://blog.163.com/yuping_fir228/blog/static/7509253320086174187588/>
