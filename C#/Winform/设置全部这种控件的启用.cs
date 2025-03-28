using System;
using System.Collections.Generic;
using System.Windows.Forms;

public class 设置全部这种控件的启用
{
    /// <summary>
    /// 递归设置指定控件及其子控件的启用状态（Enabled）。
    /// </summary>
    /// <param name="parent">父级控件</param>
    /// <param name="enabled">是否启用控件，true 表示启用，false 表示禁用</param>
    static public void SetControlsEnabled(Control parent, bool enabled)
    {
        if (parent == null) return;

        // 定义允许修改 Enabled 属性的控件类型列表
        HashSet<Type> allowedTypes = new HashSet<Type>
        {
            typeof(ComboBox),
            typeof(CheckBox),
            typeof(Button),
            typeof(NumericUpDown)
        };

        // 遍历子控件
        foreach (Control control in parent.Controls)
        {
            // 如果控件属于允许修改的类型，则修改 Enabled 属性
            if (allowedTypes.Contains(control.GetType()))
            {
                control.Enabled = enabled;
            }

            // 递归处理子控件
            if (control.Controls.Count > 0)
            {
                SetControlsEnabled(control, enabled);
            }
        }
    }
}
