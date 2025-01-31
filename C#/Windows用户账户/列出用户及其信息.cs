// 列出用户及其信息
// 列出本机所有用户，以及每个用户的以下属性：
// Name, Password, FullName, Description, AccountExpires, Disabled, PasswordNeverExpires, UserMayNotChangePassword, Group

using System;
using System.DirectoryServices;

class LocalUserLister
{
    public static void ListLocalUsers()
    {
        try
        {
            string machineName = Environment.MachineName;
            DirectoryEntry localMachine = new DirectoryEntry($"WinNT://{machineName},computer");
            
            foreach (DirectoryEntry user in localMachine.Children)
            {
                if (user.SchemaClassName == "User")
                {
                    Console.WriteLine("=========================================");
                    Console.WriteLine($"Name: {user.Name}");

                    // Try to access user properties
                    try
                    {
                        Console.WriteLine($"Full Name: {user.Properties["FullName"]?.Value}");
                        Console.WriteLine($"Description: {user.Properties["Description"]?.Value}");
                        Console.WriteLine($"Account Expires: {user.Properties["AccountExpirationDate"]?.Value ?? "Never"}");
                        Console.WriteLine($"Disabled: {user.Properties["AccountDisabled"]?.Value ?? false}");
                        Console.WriteLine($"Password Never Expires: {user.Properties["PasswordExpirationDate"]?.Value == null}");
                        Console.WriteLine($"User May Not Change Password: {user.Properties["UserFlags"]?.Value?.ToString().Contains("65536") ?? false}");
                        
                        // Extracting group membership
                        Console.WriteLine("Groups:");
                        foreach (object group in (IEnumerable)user.Invoke("Groups"))
                        {
                            DirectoryEntry groupEntry = new DirectoryEntry(group);
                            Console.WriteLine($"  - {groupEntry.Name}");
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error accessing user properties: {ex.Message}");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error listing users: {ex.Message}");
        }
    }
    
    static void Main(string[] args)
    {
        ListLocalUsers();
    }
}
