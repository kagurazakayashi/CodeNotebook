// 获取某个用户所属的用户组

using System;
using System.Collections.Generic;
using System.DirectoryServices.AccountManagement;

class UserGroupFetcher
{
    /// <summary>
    /// 获取指定用户所属的用户组列表
    /// </summary>
    /// <param name="username">用户名</param>
    /// <returns>用户组列表</returns>
    public static List<string> GetUserGroups(string username)
    {
        var groups = new List<string>();

        try
        {
            // 使用 PrincipalContext 获取用户信息
            using (var context = new PrincipalContext(ContextType.Machine))
            {
                using (var user = UserPrincipal.FindByIdentity(context, username))
                {
                    if (user == null)
                    {
                        Console.WriteLine($"用户 {username} 不存在！");
                        return groups;
                    }

                    // 遍历用户的组成员关系
                    foreach (var group in user.GetGroups())
                    {
                        groups.Add(group.Name);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"获取用户组时发生错误: {ex.Message}");
        }

        return groups;
    }

    static void Main(string[] args)
    {
        Console.WriteLine("请输入用户名:");
        string username = Console.ReadLine();

        var groups = GetUserGroups(username);

        if (groups.Count == 0)
        {
            Console.WriteLine($"用户 {username} 没有找到任何用户组或用户不存在。");
        }
        else
        {
            Console.WriteLine($"用户 {username} 所属的用户组：");
            foreach (var group in groups)
            {
                Console.WriteLine($"- {group}");
            }
        }
    }
}
