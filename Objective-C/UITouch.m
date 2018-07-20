// Touch Panel / 觸碰螢幕 / 壓力感應器的基本使用方式
// Touch Panel / 電容式的壓力感應器，更口語的說法就是大家熟知的觸碰螢幕，下列三個函式分別是在觸摸時（單次點擊）的畫面座標擷取方法、對畫面進行拖曳時的座標擷取方法，與連點畫面時的次數擷取方法，其程式碼如下。（View-based Template）
//對畫面進行單次點擊時所觸發的函式
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
 
    //宣告一個UITouch的指標來存放事件觸發時所擷取到的狀態
    UITouch *touch = [[event allTouches] anyObject];
 
    //將XY軸的座標資訊正規化後輸出
    touchX.text = [NSString stringWithFormat:@"%0.0f", [touch locationInView:touch.view].x];
    touchY.text = [NSString stringWithFormat:@"%0.0f", [touch locationInView:touch.view].y];
}

//對畫面進行拖曳動做時所觸發的函式
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
 
    //宣告一個UITouch的指標來存放事件觸發時所擷取到的狀態
    UITouch *touch = [[event allTouches] anyObject];
 
    //將XY軸的座標資訊正規化後輸出
    moveX.text = [NSString stringWithFormat:@"%0.0f", [touch locationInView:touch.view].x];
    moveY.text = [NSString stringWithFormat:@"%0.0f", [touch locationInView:touch.view].y];
}

//手指離開畫面（結束操作）時所觸發的函式
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
 
    //宣告一個UITouch的指標來存放事件觸發時所擷取到的狀態
    UITouch *touch = [[event allTouches] anyObject];
 
    //取得並輸出連點資訊，tapCount可保留一定時間內的連點次數
    tapCountLabel.text = [NSString stringWithFormat:@"%d", [touch tapCount]];
}

