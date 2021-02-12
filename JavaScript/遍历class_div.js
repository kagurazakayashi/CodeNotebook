/*
<p class="list"></p>
<p class="list"></p>
<p class="list"></p>
<div></div>
<div></div>
<div></div>
*/

var list = document.getElementsByClassName('list');
for (item in list) {
    list[item].innerHTML = '123';
}

var divs = document.getElementsByTagName("div");
for (item in divs) {
    divs[item].innerHTML = '123';
}