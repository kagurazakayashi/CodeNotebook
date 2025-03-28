using System;
using System.Linq;
using System.Windows.Forms;

public static class ListBox常用操作
{
    /// <summary>
    /// 删除 ListBox 中所有选中的项。
    /// </summary>
    /// <param name="box">要操作的 ListBox 控件</param>
    /// <exception cref="ArgumentNullException">如果 box 为空，则抛出异常</exception>
    public static void RemoveSelectedItems(ListBox box)
    {
        if (box == null)
        {
            throw new ArgumentNullException(nameof(box), "ListBox 不能为空。");
        }

        // 反向遍历 SelectedIndices，避免删除元素时索引变化导致错误
        foreach (int index in box.SelectedIndices.Cast<int>().Reverse())
        {
            box.Items.RemoveAt(index);
        }
    }

    /// <summary>
    /// 选中 ListBox 中的所有项。
    /// </summary>
    /// <param name="box">要操作的 ListBox 控件</param>
    /// <exception cref="ArgumentNullException">如果 box 为空，则抛出异常</exception>
    public static void SelectAllItems(ListBox box)
    {
        if (box == null)
        {
            throw new ArgumentNullException(nameof(box), "ListBox 不能为空。");
        }

        if (box.Items.Count == 0) return; // 如果没有数据，直接返回

        // 选中所有项
        for (int i = 0; i < box.Items.Count; i++)
        {
            box.SetSelected(i, true);
        }
    }

    /// <summary>
    /// 复制 ListBox 中选中的项到剪贴板。如果没有选中项，则先选中所有项再复制。
    /// </summary>
    /// <param name="box">要操作的 ListBox 控件</param>
    /// <exception cref="ArgumentNullException">如果 box 为空，则抛出异常</exception>
    public static void CopySelectedItemsToClipboard(ListBox box)
    {
        if (box == null)
        {
            throw new ArgumentNullException(nameof(box), "ListBox 不能为空。");
        }

        if (box.Items.Count == 0) return; // 如果列表为空，直接返回

        // 如果没有选中任何项，则先全选
        if (box.SelectedItems.Count == 0)
        {
            SelectAllItems(box);
        }

        // 获取选中的文本并复制到剪贴板
        string selectedText = string.Join(Environment.NewLine, box.SelectedItems.Cast<string>());

        if (!string.IsNullOrEmpty(selectedText))
        {
            Clipboard.SetText(selectedText);
        }
    }
}
