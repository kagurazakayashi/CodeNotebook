// C#子线程更新UI控件

// 1.使用控件自身的invoke/BeginInvoke方法
class BeginInvoke {
   private void button_Click(object sender, EventArgs e)
   {
        Thread demoThread =new Thread(new ThreadStart(threadMethod));
        demoThread.IsBackground = true;
        demoThread.Start();//启动线程
   }
   void threadMethod()
   { 
        Action<String> AsyncUIDelegate=delegate(string n){label1.Text=n;};//定义一个委托
        label1.Invoke(AsyncUIDelegate,new object[]{"修改后的label1文本"});
   }
}

// 2.使用SynchronizationContext的Post/Send方法更新
class PostSend {
    SynchronizationContext _syncContext = null;
    private void button_Click(object sender, EventArgs e)
    {
        Thread demoThread =new Thread(new ThreadStart(threadMethod));
        demoThread.IsBackground = true;
        demoThread.Start();//启动线程
    }
    //窗体构造函数
    public Form1()
    {
        InitializeComponent();
          //获取UI线程同步上下文
        _syncContext = SynchronizationContext.Current;
    }
    private void threadMethod()
    {
         _syncContext.Post(SetLabelText, "修改后的文本");//子线程中通过UI线程上下文更新UI
    }
    private void SetLabelText(object text)
    {
        this.lable1.Text = text.ToString();
    }
}

// https://blog.csdn.net/jqncc/article/details/16342121