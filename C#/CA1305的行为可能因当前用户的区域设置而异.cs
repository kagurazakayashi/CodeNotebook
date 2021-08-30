// 解决 CA1305
NumberFormatInfo nfi = new NumberFormatInfo();
nfi.NumberDecimalDigits = 0;
string str = Convert.ToString(num, nfi); // 没有 nfi 报 CA1305