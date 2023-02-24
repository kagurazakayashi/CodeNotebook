import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.util.Log;

public class MessageTest {

    /**
     * 接收子线程发来的消息的 Handler
     */
    private final Handler handler = new Handler(Looper.getMainLooper()) {
        @Override
        public void handleMessage(Message msg) {
            if (msg.what == 1) {
                // 搜尋到的各個藍芽裝置 (JSON)
                Log.i("v=", msg.getData().getString("v"));
            }
        }
    };

    /**
     * 构造方法
     */
    public MessageTest() {
        onIntervalScanUpdate();
    }

    /**
     * 架设这是一个子线程
     */
    private void onIntervalScanUpdate() {
        Message message = new Message();
        message.what = 1;
        Bundle bundle = new Bundle();
        bundle.putString("k", "v");
        message.setData(bundle);
        handler.sendMessage(message);
    }
}
