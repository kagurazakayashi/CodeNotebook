//转换为 CSV
var cell = document.getElementsByTagName("table")[0].getElementsByTagName("tr");
var cstr = "";
for (var i = 1; i < cell.length; i++) {
    var unit = cell[i].getElementsByTagName("td");
    for (var j = 0; j < unit.length-1; j++) {
        var nowdata = unit[j];
        var nstr = nowdata.innerText.replace("\n", "");
        if (j < unit.length-2) {
            nstr += ",";
        } else {
            nstr = nstr.replace("(", ",").replace(")", "");
        }
        cstr += nstr;
    }
    cstr += "\n";
}
console.log(cstr);

//转换为SQL
//INSERT INTO `ack` (`time`, `ip`, `app`, `url`, `method`, `type`, `ackip`, `ackaddr`) VALUES ('2018-11-20 02:55:55', '123.56.133.111', 'www.futureracing.com.cn', 'http://www.futureracing.com.cn//data/cache.php', 'POST', '脚本木马', '161.117.143.164', '澳大利亚')

var cell = document.getElementsByTagName("table")[0].getElementsByTagName("tr");
var cstr = "";
for (var i = 1; i < cell.length-1; i++) {
    var nsql = "INSERT INTO `ack` (`time`, `ip`, `app`, `url`, `method`, `type`, `ackip`, `ackaddr`) VALUES ('";
    var unit = cell[i].getElementsByTagName("td");
    for (var j = 0; j < unit.length-1; j++) {
        var nowdata = unit[j];
        var nstr = nowdata.innerText.replace("\n", "");
        if (j < unit.length-2) {
            nstr += "', '";
        } else {
            nstr = nstr.replace("(", "', '").replace(")", "");
        }
        nsql += nstr;
    }
    nsql += "');\n";
    cstr = nsql + cstr;
}
console.log(cstr);
