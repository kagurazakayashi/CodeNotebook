using System.Windows.Forms;

public static class 把窗口移到前台
{
    /// <summary>
    /// 激活或取消激活窗口，并调整其状态。
    /// </summary>
    /// <param name="form">目标窗体</param>
    /// <param name="isActivate">是否激活窗口（true: 置顶并恢复窗口，false: 取消置顶）</param>
    public static void ActivateWindow(Form form, bool isActivate)
    {
        if (form == null) return; // 防止空引用异常

        // 如果需要激活窗口，且当前窗口是最小化状态，则恢复正常状态
        if (isActivate)
        {
            if (form.WindowState == FormWindowState.Minimized)
            {
                form.WindowState = FormWindowState.Normal;
            }

            // 确保窗口在最前面
            form.TopMost = true;
            form.Activate(); // 让窗口获得焦点
        }
        else
        {
            // 取消窗口置顶
            form.TopMost = false;
        }
    }
}
