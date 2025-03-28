using System;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Globalization;

class Program
{
    static void 获取程序的标题和版本号等Main()
    {
        // 获取当前程序集
        Assembly assembly = Assembly.GetExecutingAssembly();
        AssemblyName assemblyName = assembly.GetName();

        // 获取程序集的自定义属性
        string title = GetAttribute<AssemblyTitleAttribute>(assembly)?.Title ?? "N/A";
        string description = GetAttribute<AssemblyDescriptionAttribute>(assembly)?.Description ?? "N/A";
        string company = GetAttribute<AssemblyCompanyAttribute>(assembly)?.Company ?? "N/A";
        string product = GetAttribute<AssemblyProductAttribute>(assembly)?.Product ?? "N/A";
        string copyright = GetAttribute<AssemblyCopyrightAttribute>(assembly)?.Copyright ?? "N/A";
        string trademark = GetAttribute<AssemblyTrademarkAttribute>(assembly)?.Trademark ?? "N/A";
        string guid = GetAttribute<GuidAttribute>(assembly)?.Value ?? "N/A";
        string neutralLanguage = GetAttribute<NeutralResourcesLanguageAttribute>(assembly)?.CultureName ?? "N/A";

        // 获取版本信息
        string assemblyVersion = assemblyName.Version?.ToString() ?? "N/A";
        string fileVersion = GetAttribute<AssemblyFileVersionAttribute>(assembly)?.Version ?? "N/A";

        // 输出信息
        Console.WriteLine($"标题（Title）: {title}");
        Console.WriteLine($"说明（Description）: {description}");
        Console.WriteLine($"公司（Company）: {company}");
        Console.WriteLine($"产品（Product）: {product}");
        Console.WriteLine($"版权（Copyright）: {copyright}");
        Console.WriteLine($"商标（Trademark）: {trademark}");
        Console.WriteLine($"程序集版本（Assembly Version）: {assemblyVersion}");
        Console.WriteLine($"文件版本（File Version）: {fileVersion}");
        Console.WriteLine($"GUID: {guid}");
        Console.WriteLine($"非特定语言（Neutral Language）: {neutralLanguage}");
    }

    // 泛型方法用于获取程序集属性
    static T GetAttribute<T>(Assembly assembly) where T : Attribute
    {
        return (T)Attribute.GetCustomAttribute(assembly, typeof(T));
    }
}
