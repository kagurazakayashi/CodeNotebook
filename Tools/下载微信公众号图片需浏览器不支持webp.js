var imags = document.getElementsByTagName('img');
var curl = ""; 
for(i = 0, length = imags.length; i < length; i++){
   if(!imags[i]) continue
   var src = imags[i].getAttribute('src');
   if(src){
      ncurl = "curl -o img"+i+".jpg \""+src+"\"\n";
      curl += ncurl;
   }
}
console.log(curl);