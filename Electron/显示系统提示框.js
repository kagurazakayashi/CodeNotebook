/*
* main.js
*/
ipcMain.on('openDiglog', function (event, args) {
    if (args.type == '') {
        dialog.showErrorBox(args.title, args.message);
    } else {
        if (args.type.substr(0, 1) == '-') {
            args.type = args.type.substr(1);
            dialog.showMessageBoxSync(args);
        } else {
            dialog.showMessageBox(args);
        }
    }
})


/*
* other js
*/
if (itemID == 0) {
    alert('继续');
} else {
    ipcRenderer.send('openDiglog', {
        type: '-warning',
        title: '无法使用该组件',
        message: '此功能尚未提供',
        buttons: ['OK']
    });
}