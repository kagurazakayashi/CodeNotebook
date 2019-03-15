var str = "";
$(".jItem").each(function(){
    var goodspic = $(this).find(".jPic img").attr("src");
    var goodstext = $(this).find(".jDesc a").text();
    goodspic = goodspic.split('!')[0];
    str += 'curl "https:'+goodspic+'" -o "'+goodstext+'.jpg"\n';
});
console.log(str);