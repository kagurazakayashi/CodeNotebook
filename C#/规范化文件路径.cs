using System;
using System.IO;
using System.Text.RegularExpressions;
using System.Windows.Forms;

public static class 规范化文件路径
{
    /// <summary>
    /// 规范化文件路径，将多个斜杠替换为单个，并返回绝对路径。
    /// </summary>
    /// <param name="path">要规范化的路径</param>
    /// <returns>规范化后的绝对路径</returns>
    /// <exception cref="ArgumentNullException">如果 path 为空，则抛出异常</exception>
    public static string NormalizePath(string path)
    {
        if (string.IsNullOrWhiteSpace(path))
        {
            throw new ArgumentNullException(nameof(path), "路径不能为空或仅包含空格。");
        }

        // 获取绝对路径，并移除末尾的目录分隔符（除根目录外）
        return Path.GetFullPath(path).TrimEnd(Path.DirectorySeparatorChar);
    }
}
