var aspan = document.getElementsByClassName("next-table-cell last");
var alength = aspan.length;
var aii = 0;
function adownload() {
    if (aii < alength) {
        var ahref = aspan[aii].getElementsByTagName("a")[0].attributes["href"].value;
        console.log((aii+1)+"/"+alength+" : "+ahref);
        window.open(ahref);
        aii++;
    } else {
        window.clearInterval(atimer);
        atimer = null;
    }
}
var atimer = self.setInterval("adownload()",100);

//ziped
var aspan=document.getElementsByClassName("next-table-cell last"),alength=aspan.length,aii=0;function adownload(){if(aii<alength){var a=aspan[aii].getElementsByTagName("a")[0].attributes.href.value;console.log(aii+1+"/"+alength+" : "+a),window.open(a),aii++}else window.clearInterval(atimer),atimer=null}var atimer=self.setInterval("adownload()",100);
