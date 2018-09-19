var hrefArr = document.getElementsByTagName('a');
var hrefStr = "";
for(var i=0;i<hrefArr.length;i++){hrefStr = hrefStr+'\nwget -e "http_proxy=127.0.0.1:1080" '+hrefArr[i].href;}
