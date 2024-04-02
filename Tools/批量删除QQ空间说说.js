var temp = true;

function clickDel() {
    try {
        document.querySelector('.app_canvas_frame').contentDocument.querySelector('.del_btn').click();
    } catch{
        var a = document.querySelector('.app_canvas_frame').contentDocument.querySelector('.mod_pagenav_main').querySelectorAll('.c_tx');
        a[a.length - 1].click();
        temp = false;
        setTimeout(clickDel, 2000);
    }
    setTimeout(clickYes, temp ? 2000 : 5000);
    temp = true;
}
function clickYes() {
    document.querySelector('.qz_dialog_layer_btn').click();
    setTimeout(clickDel, 2000);
}

clickDel()