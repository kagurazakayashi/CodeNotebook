OpenFileDialog openFileDialog1 = new OpenFileDialog();

if (openFileDialog1.ShowDialog() == DialogResult.OK)
{
    openFileDialog1.FileName;
    System.IO.FileInfo file = new System.IO.FileInfo(openFileDialog1.FileName);

    file.Name;//文件名
    file.Length.ToString();//大小",
    file.LastAccessTime.ToString();//最后访问时间
    file.LastWriteTime.ToString();//最后修改时间
    file.DirectoryName;//路径
}

// https://www.cnblogs.com/Hdsome/archive/2012/02/02/2335344.html