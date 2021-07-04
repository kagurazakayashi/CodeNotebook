// main.ts

import * as fs from 'fs';
ipcMain.on('saveDialog', (event, args) => {
    const options = args[0];
    const saveText = args[1];
    dialog.showSaveDialog(mainWindow, options).then(result => {
        if (result.canceled || !result.filePath) {
            mainWindow.webContents.send('saveDialogOK', [0, '']);
            return
        }
        mainWindow.webContents.send('saveDialogOK', [1, result.filePath]);
        fs.writeFileSync(result.filePath, saveText);
    }).catch(err => {
        mainWindow.webContents.send('saveDialogOK', [-1, err.toString()]);
    })
});

// other.ts
() => {
    const options = [{
        title: '导出日志',
        filters: [
            {
                name: '日志文件',
                extensions: ['log']
            },
            {
                name: '文本文档',
                extensions: ['txt']
            }
        ],
        properties: ['createDirectory', 'showOverwriteConfirmation'],
    }, that.outputBoxLines.innerText];
    ipcRenderer.send('saveDialog', options);
    ipcRenderer.on('saveDialogOK', (event, args) => {
        ipcRenderer.removeAllListeners('saveDialogOK');
        const stat = args[0];
        const path = args[1];
        if (stat == -1) {
            ipcRenderer.send('openDiglog', {
                type: '-error',
                title: '保存日志文件失败',
                message: path,
                buttons: ['取消']
            });
        }
    });
};