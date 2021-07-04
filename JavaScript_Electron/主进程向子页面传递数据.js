// 主
win.webContents.on('did-finish-load', function(){
   win.webContents.send('dataJsonPort', data);
});

// 子
ipcRenderer.on('dataJsonPort', function(event, arg) { // 监听父页面定义的端口
    //arg
});
