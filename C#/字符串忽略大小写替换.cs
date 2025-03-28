using System;
using System.Text;

public class 字符串忽略大小写替换
{
    /// <summary>
    /// 在不区分大小写的情况下，替换字符串中的所有指定子字符串。
    /// </summary>
    /// <param name="input">输入字符串</param>
    /// <param name="oldValue">要被替换的子字符串</param>
    /// <param name="newValue">用于替换的新字符串</param>
    /// <returns>返回替换后的字符串</returns>
    /// <exception cref="ArgumentNullException">如果 input 或 oldValue 为空，则抛出异常</exception>
    static public string ReplaceIgnoringCase(string input, string oldValue, string newValue)
    {
        // 参数校验，防止 null 传入导致异常
        if (input == null) throw new ArgumentNullException(nameof(input), "输入字符串不能为空");
        if (oldValue == null) throw new ArgumentNullException(nameof(oldValue), "需要替换的子字符串不能为空");
        if (oldValue.Length == 0) return input; // 避免死循环

        StringBuilder result = new StringBuilder();
        int index = 0, lastIndex = 0;

        // 遍历 input，查找 oldValue（忽略大小写）
        while ((index = input.IndexOf(oldValue, index, StringComparison.OrdinalIgnoreCase)) != -1)
        {
            // 追加前一部分未匹配的字符串
            result.Append(input, lastIndex, index - lastIndex);

            // 追加替换后的字符串
            result.Append(newValue);

            // 移动索引，避免死循环
            index += oldValue.Length;
            lastIndex = index;
        }

        // 追加剩余未匹配的部分
        result.Append(input, lastIndex, input.Length - lastIndex);

        return result.ToString();
    }
}
