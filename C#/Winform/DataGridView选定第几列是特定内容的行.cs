using System.Windows.Forms;

public static class 选定第几列是特定内容的行
{
    /// <summary>
    /// 在 DataGridView 中查找指定单元格值的行，并选中该行。
    /// </summary>
    /// <param name="dataGridView">目标 DataGridView 控件</param>
    /// <param name="cellIndex">要查找的列索引</param>
    /// <param name="cellValue">要匹配的字符串值</param>
    public static void SelectDataGridViewRow(DataGridView dataGridView, int cellIndex, string cellValue)
    {
        // 先清除所有已选中行
        dataGridView.ClearSelection();

        // 遍历所有行
        foreach (DataGridViewRow row in dataGridView.Rows)
        {
            // 忽略新行
            if (row.IsNewRow) continue;

            // 获取当前行指定列的单元格值
            var cellObj = row.Cells[cellIndex].Value;

            // 判断单元格值是否与目标值匹配
            if (cellObj != null && object.Equals(cellObj.ToString(), cellValue))
            {
                row.Selected = true; // 选中该行
            }
        }
    }

    /// <summary>
    /// 在 DataGridView 中查找指定单元格的布尔值，并选中该行。
    /// </summary>
    /// <param name="dataGridView">目标 DataGridView 控件</param>
    /// <param name="cellIndex">要查找的列索引</param>
    /// <param name="cellValue">要匹配的布尔值</param>
    public static void SelectDataGridViewRow(DataGridView dataGridView, int cellIndex, bool cellValue)
    {
        // 先清除所有已选中行
        dataGridView.ClearSelection();

        // 遍历所有行
        foreach (DataGridViewRow row in dataGridView.Rows)
        {
            // 忽略新行
            if (row.IsNewRow) continue;

            // 获取当前行指定列的单元格值并尝试转换为布尔值
            if (row.Cells[cellIndex].Value is bool isChecked && isChecked == cellValue)
            {
                row.Selected = true; // 选中该行
            }
        }
    }
}
