// 创建后自动开始计时
var countDownNum = 5
Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
    if countDownNum == 0 {
      	// 销毁计时器
        timer.invalidate()
        // countDownNum = 5
        print(">>> Timer has Stopped!")
    } else {
        print(">>> Countdown Number: \(countDownNum)")
        countDownNum -= 1
    }
}


// 创建后手动开始计时
var countDownNum = 5
let countdownTimer = Timer(timeInterval: 1.0, repeats: true) { timer in
    if countDownNum == 0 {
      	// 销毁计时器
        timer.invalidate()
        // countDownNum = 5
        print(">>> Timer has Stopped!")
    } else {
        print(">>> Countdown Number: \(countDownNum)")
        countDownNum -= 1
    }
}
// 设置宽容度
countdownTimer.tolerance = 0.2
// 添加到当前 RunLoop，mode为默认。
RunLoop.current.add(countdownTimer, forMode: .default)
// 开始计时
countdownTimer.fire()


// 判断计时器是否有效
// isValid 用于判断计时器是否有效
// 当销毁计时器时 .invalidate() ，此属性为 false 。如果还能 .fire() ，此属性为 true。