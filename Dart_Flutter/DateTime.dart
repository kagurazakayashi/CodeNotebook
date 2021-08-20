DateTime _datetime;
_datetime = new DateTime.now();
//时间戳
_datetime.millisecondsSinceEpoch.toString();
//时间：2019-01-02 12:12:12.5451515
_datetime.toString();

//有格式的时间：2019-01-02 12:12:12
String _timestamp =
            "${_datetime.year.toString()}-${_datetime.month.toString().padLeft(2, '0')}-${_datetime.day.toString().padLeft(2, '0')} ${_datetime.hour.toString().padLeft(2, '0')}:${_datetime.minute.toString().padLeft(2, '0')}:${_datetime.second.toString().padLeft(2, '0')}";
