// 列出本机用户及其信息：使用用户对象
// 为每个用户创建一个信息对象，并将这些信息对象在一个数组中返回。

using System;
using System.Collections;
using System.Collections.Generic;
using System.DirectoryServices;

public class UserInfo
{
    public string Name { get; set; }
    public string FullName { get; set; }
    public string Description { get; set; }
    public string AccountExpires { get; set; }
    public bool Disabled { get; set; }
    public bool PasswordNeverExpires { get; set; }
    public bool UserMayNotChangePassword { get; set; }
    public List<string> Groups { get; set; }
}

public class LocalUserLister
{
    public static List<UserInfo> GetLocalUsers()
    {
        var users = new List<UserInfo>();
        
        try
        {
            string machineName = Environment.MachineName;
            DirectoryEntry localMachine = new DirectoryEntry($"WinNT://{machineName},computer");

            foreach (DirectoryEntry user in localMachine.Children)
            {
                if (user.SchemaClassName == "User")
                {
                    var userInfo = new UserInfo
                    {
                        Name = user.Name,
                        FullName = user.Properties["FullName"]?.Value?.ToString(),
                        Description = user.Properties["Description"]?.Value?.ToString(),
                        AccountExpires = user.Properties["AccountExpirationDate"]?.Value?.ToString() ?? "Never",
                        Disabled = user.Properties["AccountDisabled"]?.Value != null && (bool)user.Properties["AccountDisabled"].Value,
                        PasswordNeverExpires = user.Properties["PasswordExpirationDate"]?.Value == null,
                        UserMayNotChangePassword = user.Properties["UserFlags"]?.Value?.ToString().Contains("65536") ?? false,
                        Groups = new List<string>()
                    };

                    // Retrieve group memberships
                    try
                    {
                        foreach (object group in (IEnumerable)user.Invoke("Groups"))
                        {
                            DirectoryEntry groupEntry = new DirectoryEntry(group);
                            userInfo.Groups.Add(groupEntry.Name);
                        }
                    }
                    catch
                    {
                        userInfo.Groups.Add("Error retrieving groups");
                    }

                    users.Add(userInfo);
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error listing users: {ex.Message}");
        }

        return users;
    }

    static void Main(string[] args)
    {
        var users = GetLocalUsers();

        foreach (var user in users)
        {
            Console.WriteLine("=========================================");
            Console.WriteLine($"Name: {user.Name}");
            Console.WriteLine($"Full Name: {user.FullName}");
            Console.WriteLine($"Description: {user.Description}");
            Console.WriteLine($"Account Expires: {user.AccountExpires}");
            Console.WriteLine($"Disabled: {user.Disabled}");
            Console.WriteLine($"Password Never Expires: {user.PasswordNeverExpires}");
            Console.WriteLine($"User May Not Change Password: {user.UserMayNotChangePassword}");
            Console.WriteLine("Groups:");
            foreach (var group in user.Groups)
            {
                Console.WriteLine($"  - {group}");
            }
        }
    }
}
