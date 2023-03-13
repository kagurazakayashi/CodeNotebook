string clipText = "";
IDataObject iData = Clipboard.GetDataObject();
//检测文本
if (iData.GetDataPresent(DataFormats.Text) | iData.GetDataPresent(DataFormats.OemText))
{
    clipText = (String)iData.GetData(DataFormats.Text);
}