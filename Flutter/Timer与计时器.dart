//开始
_timer = new Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _datetime = new DateTime.now();
        _timestamp =
            "${_datetime.year.toString()}-${_datetime.month.toString().padLeft(2, '0')}-${_datetime.day.toString().padLeft(2, '0')} ${_datetime.hour.toString().padLeft(2, '0')}:${_datetime.minute.toString().padLeft(2, '0')}:${_datetime.second.toString().padLeft(2, '0')}";
      });
    });

//结束
_timer.cancel();

//计时器
  void startCountdownTimer() {
    const fiveSec = const Duration(seconds: 5);
    var callback = (timer) => {
          setState(() {
            if (_subtime < 1) {
              _timer.cancel();
            } else {
              _subtime = _subtime - 5;
            }
          })
        };
    _timer = Timer.periodic(fiveSec, callback);
  }