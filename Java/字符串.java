// 一、创建并初始化字符串：

// 　　1、使用字符串常量直接初始化
    String s="hello!";

// 　　2、使用构造方法创建并初始化

   String();//初始化一个对象，表示空字符序列

　　String(value);//利用已存在的字符串常量创建一个新的对象

　　String (char[] value);//利用一个字符数组创建一个字符串

　　String(char[] value,int offset,int count);//截取字符数组offset到count的字符创建一个非空串

　　String(StringBuffer buffer);//利用StringBuffer对象初始化String对象

// 　　二、String类主要方法的使用：

// 　　1、获取长度
    *.length();//这与数组中的获取长度不同，*.length;

// 　　2、比较字符串
    equals() //判断内容是否相同

　　compareTo() //判断字符串的大小关系

　　compareToIgnoreCase(String int) //在比较时忽略字母大小写

　　== //判断内容与地址是否相同

　　equalsIgnoreCase() //忽略大小写的情况下判断内容是否相同

// 　　如果想对字符串中的部分内容是否相同进行比较，可以用

　　reagionMatches() //有两种 public boolean regionMatches(int toffset, String other,int ooffset,int len);表示如果String对象的一个子字符串与参数other的一个子字符串是相同的字符序列，则为true.要比较的String 对象的字符串从索引toffset开始,other的字符串从索引ooffset开始，长度为len。

　　public boolean reagionMatches(boolean ignoreCase,int toffset,String other,int ooffset,int len);//用布尔类型的参数指明两个字符串的比较是否对大小写敏感。

// 　　三、查找字符串中某个位置的字符

　　public char charAt(int index);//返回指定索引index位置上的字符，索引范围从0开始

// 　　四、查找指定字符串在字符串中第一次或最后一词出现的位置

// 　　在String类中提供了两种查找指定位置的字符串第一次出现的位置的方法

　　public int indexOf(String str);//从字符串开始检索str，并返回第一次出现的位置，未出现返回-1

　　public int indexOf(String str,int fromIndex);//从字符串的第fromIndex个字符开始检索str

// 　　查找最后一次出现的位置有两种方法

　　public int lastIndexOf(String str);

　　public int lastIndexOf(String str,int fromIndex);

// 　　如果不关心字符串的确切位置则可使用
    public boolean contains(CharSequence s);

// 　　五、检查字符串的起始字符和结束字符

// 　　开始的字符串两种方法

　　public boolean starWith(String prefix,int toffset);//如果参数prefix表示的字符串序列是该对象从索引toffset处开始的子字符串，则返回true

　　public boolean starWith(String prefix);

// 　　结束的字符串方法

　　public boolean endsWith(String suffix);

// 　　六、截取子串

　　public String subString(int beginIndex);

　　public String subString(int beginIndex,int endIndex);//返回的字符串是从beginIndex开始到endIndex-1的串

// 　　要返回后4位可以这样写
    Syetem.out.println(*.substring()(*.length()-4));

// 　　七、字符串的替换

// 　　两种方法

　　public String replace(char oldChar,char newChar);

　　public String replace(CharSequence target,CharSequence replacement);//把原来的etarget子序列替换为replacement序列，返回新串

　　public String replaceAll(String regex,String replacement);//用正则表达式实现对字符串的匹配

// 　　八、字符串的大小写替转换

　　public String toLowerCase(Locale locale);

　　public String toLowerCase();

　　public String toupperCase(Locale locale);

　　public String toUpperCase();

// 　　九、去除字符串首尾空格

　　*.trim();

// 　　十、字符串转换

// 　　1、将字符串转换成字符数组

　　public char[] toCharArray();

// 　　2、将字符串转换成字符串数组

　　public String[] split(String regex);//regex 是给定的匹配

// 　　3、将其它数据类型转化为字符串

　　public static String valueOf(boolean b);

　　public static String valueOf(char c);

　　public static String valueOf(int i);

　　public static String valueOf(long i);

　　public static String valueOf(float f);

　　public static String valueOf(double d);

　　public static String valueOf(char[] data);

　　public static String valueOf(Object obj);

// 　　可变字符串的创建和初始化

// 　　两种方法:

　　public StringBuffer();

　　public StringBuffer(int caoacity);

// 　　StringBuffer类主要方法的使用：

// 　　一、获取可变字符串长度

　　public int length();

　　public int capacity();

　　public void setLength(int newLength);

// 　　二、比较可变字符串

// 　　用String 类的equals()方法比较，但是不同。

// 　　类Object中的equals()方法比较的是两个对象的地址是否相等，而不仅仅是比较内容，但是String类在继承Object类的时候重写了equals()方法，只是比较两个对象的内容是否相等

// 　　而在StringBuffer类中没有重写Object类的equals()方法，所以比较的是地址和内容。

// 　　三、追加和插入字符串

// 　　(1)追加
    public StringBuffer append(type t);

// 　　(2)插入
    public StringBuffer insert(int offset,type t);//在offset处加入类型为type的字符串

// 　　四、反转和删除字符串

// 　　(1)反转
    public StringBuffer reverse();

// 　　(2)删除
    public StringBuffer delete(int start,int end);

// 　　五、减少用于可变字符序列的存储空间

　　public void trimToSize();

// 　　六、StringBuffer类转换成String类

　　public String toString();
