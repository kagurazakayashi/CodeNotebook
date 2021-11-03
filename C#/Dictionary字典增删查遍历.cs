// Dictionary 字典
using System;
using System.Collections.Generic;
public class Example
{
         public static void Main()
         {
               //一、创建泛型哈希表，然后加入元素
               Dictionary<string, string> oscar = new Dictionary<string, string>();
               oscar.Add("哈莉·贝瑞", "《死囚之舞》");
               oscar.Add("朱迪·丹奇", "《携手人生》");
               oscar.Add("尼科尔·基德曼", "《红磨坊》");
               oscar.Add("詹妮弗·康纳利", "《美丽心灵》");
               oscar.Add("蕾妮·齐维格", "《BJ单身日记》");

               //二、删除元素
               oscar.Remove("詹妮弗·康纳利");

               //三、假如不存在元素则加入元素
               if (!oscar.ContainsKey("茜茜·斯派克")) oscar.Add("茜茜·斯派克", "《不伦之恋》");
               

               //四、显然容量和元素个数
               Console.WriteLine("元素个数: {0}", oscar.Count);

               //五、遍历集合
               Console.WriteLine("74届奥斯卡最佳女主角及其电影：");
               foreach (KeyValuePair<string, string> kvp in oscar)
               {
                      Console.WriteLine("姓名：{0},电影：{1}", kvp.Key, kvp.Value);
               }

              //六、得到哈希表中键的集合
              Dictionary<string, string>.KeyCollection keyColl = oscar.Keys;
              //遍历键的集合
              Console.WriteLine("最佳女主角：");
              foreach (string s in keyColl)
              {
                   Console.WriteLine(s);
              }

              //七、得到哈希表值的集合
              Dictionary<string, string>.ValueCollection valueColl = oscar.Values;
              //遍历值的集合
              Console.WriteLine("最佳女主角电影：");
              foreach (string s in valueColl)
              {
                   Console.WriteLine(s);
              }

              //八、使用TryGetValue方法获取指定键对应的值
              string slove = string.Empty;
              if (oscar.TryGetValue("朱迪·丹奇", out slove))
                     Console.WriteLine("我最喜欢朱迪·丹奇的电影{0}", slove);
              else
                     Console.WriteLine("没找到朱迪·丹奇的电影");

              //九、清空哈希表
              oscar.Clear();
              Console.ReadLine();
       }
}

// https://www.cnblogs.com/gengaixue/p/4002244.html