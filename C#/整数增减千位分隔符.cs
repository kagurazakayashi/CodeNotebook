using System;
using System.Globalization;

public static class 整数增减千位分隔符
{
    /// <summary>
    /// 将字符串表示的数字格式化为带有千分位分隔符的字符串。
    /// </summary>
    /// <param name="numberString">要格式化的数字字符串（仅支持整数）</param>
    /// <returns>格式化后的字符串（带千分位），如果输入无效则返回空字符串。</returns>
    public static string FormatNumberWithSeparators(string numberString)
    {
        // 检查输入是否为空，避免不必要的解析
        if (string.IsNullOrWhiteSpace(numberString))
        {
            return string.Empty;
        }

        // 尝试解析字符串为 long 类型（支持较大整数）
        if (long.TryParse(numberString, out long number))
        {
            // 按照千分位格式化，不带小数部分
            return number.ToString("N0", CultureInfo.InvariantCulture);
        }

        return string.Empty; // 解析失败返回空字符串
    }

    /// <summary>
    /// 解析带有千分位分隔符的数字字符串，并转换为 int 类型。
    /// </summary>
    /// <param name="formattedNumber">带有千分位分隔符的数字字符串</param>
    /// <returns>转换后的 int 类型数值，如果解析失败则返回 0。</returns>
    public static int ParseNumberWithSeparators(string formattedNumber)
    {
        // 检查输入是否为空
        if (string.IsNullOrWhiteSpace(formattedNumber))
        {
            return 0;
        }

        // 尝试解析千分位格式的数字字符串
        if (int.TryParse(formattedNumber, NumberStyles.AllowThousands, CultureInfo.InvariantCulture, out int number))
        {
            return number;
        }

        return 0; // 解析失败返回 0
    }
}
