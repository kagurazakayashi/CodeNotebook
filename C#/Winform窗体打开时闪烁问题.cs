// 解决 C# Winform 窗体打开时闪烁问题
// 这个问题属于必须解决的问题，而且界面的控件越多，闪烁也越多，试过多种解决办法效果都不理想。

// 解决办法：把此段代码加入到窗体代码中

protected override CreateParams CreateParams {
    get {
        CreateParams paras = base.CreateParams;
        paras.ExStyle |= 0x02000000;
        return paras;
    }
}

// 主要原因是对于Winform来说，一个窗体中绘制多个控件是很花时间的。特别是默认的按钮控件。Form先画出背景，然后留下控件需要的“洞”。如果控件的背景是透明的，那么这些“洞”就会先以白色或黑色出现，然后每个控件的“洞”再被填充，就是我们所看到的闪烁，在WinForm中没有现成的解决方案。设置控件双缓冲并不能解决它，因为它只适用于自己，而不是复合控件集。

// https://www.jianshu.com/p/15e2177e3122