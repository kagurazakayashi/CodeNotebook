// 方法一： view.post(Runnable action)
// 假如该方法是在子线程中
textView.post(new Runnable() {
    @Override
    public void run() {
        textView.setText("更新textView");
        //还可以更新其他的控件
        imageView.setBackgroundResource(R.drawable.update);
    }
});
// 这是view自带的方法，比较简单，如果你的子线程里可以得到要更新的view的话，可以用此方法进行更新。
// view还有一个方法view.postDelayed(Runnable action, long delayMillis)用来延迟发送。

// 方法二： activity.runOnUiThread(Runnable action)
// 假如该方法是在子线程中
// 注意：context 对象要是 主线程中的MainActivity，这样强转才可以。
public void updateUI(final Context context) {
    ((MainActivity) context).runOnUiThread(new Runnable() {
        @Override
        public void run() {
            //此时已在主线程中，可以更新UI了
        }
    });
}
// 如果没有上下文（context），试试下面的方法：
// 1.用view.getContext()可以得到上下文。
// 2.跳过context直接用new Activity().runOnUiThread(Runnable action)来切换到主线程。


// 方法三： Handler机制
// 首先在主线程中定义Handler，Handler mainHandler = new Handler();（必须要在主线程中定义才能操作主线程，如果想在其他地方定义声明时要这样写Handler mainHandler = new Handler(Looper.getMainLooper())，来获取主线程的 Looper 和 Queue ）
// 获取到 Handler 后就很简单了，用handler.post(Runnable r)方法把消息处理放在该 handler 依附的消息队列中（也就是主线程消息队列）。

// （1）：假如该方法是在子线程中
Handler mainHandler = new Handler(Looper.getMainLooper());
mainHandler.post(new Runnable() {
    @Override
    public void run() {
        //已在主线程中，可以更新UI
    }
});
// Handler还有下面的方法：
// 1.postAtTime(Runnable r, long uptimeMillis); //在某一时刻发送消息
// 2.postAtDelayed(Runnable r, long delayMillis); //延迟delayMillis毫秒再发送消息

// （2）: 假设在主线程中
Handler myHandler = new Handler() {
    @Override
    public void handleMessage(Message msg) {
        switch(msg.what) {
            case 0:
                //更新UI等
                break;
            case 1:
                    //更新UI等
                break;
            default:
                break;
        }
    }
}
// 之后可以把 mainHandler 当做参数传递在各个类之间，当需要更新UI时，可以调用sendMessage一系列方法来执行handleMessage里的操作。

// 方法四： 使用AsyncTask

// https://blog.csdn.net/da_caoyuan/article/details/52931007