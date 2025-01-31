//启动子线程
ThreadPool.QueueUserWorkItem(m =>
{
    //...
});

//等待子线程运行完成后执行
ManualResetEvent resetEvent = new ManualResetEvent(false);
ThreadPool.QueueUserWorkItem(m =>
{
    //...
    resetEvent.Set();
});
resetEvent.WaitOne();
//...