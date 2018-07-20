JOptionPane.showMessageDialog(newFrame.getContentPane(),
"弹出的是消息提示框!", "系统信息", JOptionPane.INFORMATION_MESSAGE);
JOptionPane.showMessageDialog(newFrame.getContentPane(),
"弹出的是警告提示框!", "系统信息", JOptionPane.WARNING_MESSAGE);
JOptionPane.showMessageDialog(newFrame.getContentPane(),
"弹出的是错误提示框!", "系统信息", JOptionPane.ERROR_MESSAGE);
JOptionPane.showMessageDialog(newFrame.getContentPane(),
"弹出的是询问提示框!", "系统信息", JOptionPane.QUESTION_MESSAGE);

int option = JOptionPane.showConfirmDialog(null,
    "文件已修改，是否保存？", "保存文件？", JOptionPane.YES_NO_OPTION,
    JOptionPane.QUESTION_MESSAGE, null);
switch (option) {
    case JOptionPane.YES_NO_OPTION: {
        //saveAsFile();
        break;
    }
    case JOptionPane.NO_OPTION: {
        //System.exit(0);
        break;
    }
}
