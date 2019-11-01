var listallfiletype_e = []; //要提取的文件扩展名，空数组=不限制
var listallfiletype_p = 'wget -e "http_proxy=http://127.0.0.1:8081" '; //前缀
var listallfiletype_a = document.getElementsByTagName("a");
var listallfiletype_r = new Array();
for(var listallfiletype_ai in listallfiletype_a) {
    const aboj = listallfiletype_a[listallfiletype_ai];
    const ahref = aboj.href;
    if (typeof ahref !== "undefined") {
        if (listallfiletype_e.length == 0) {
            listallfiletype_r.push(listallfiletype_p+ahref);
        } else {
            for(var listallfiletype_ei in listallfiletype_e) {
                const eboj = listallfiletype_e[listallfiletype_ei];
                const ebojlength = eboj.length;
                if (ebojlength < ahref.length) {
                    const atype = ahref.slice(0 - ebojlength);
                    if (atype == eboj) {
                        listallfiletype_r.push(listallfiletype_p+ahref);
                    }
                }
            }
        }
    }
}
listallfiletype_r = listallfiletype_r.join("\n");
console.log(listallfiletype_r);