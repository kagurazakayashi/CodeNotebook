function mkmenu() {
    const version = app.getVersion();
    let menutmp = [{
        label: '文件',
        submenu: [{
            label: '退出',
            accelerator: 'CmdOrCtrl+Q',
            click: () => {
                app.quit()
            }
        }]
    },{
        label: '编辑',
        submenu: [{
            label: '撤销',
            accelerator: 'CmdOrCtrl+Z',
            role: 'undo'
        },{
            label: '重做',
            accelerator: 'Shift+CmdOrCtrl+Z',
            role: 'redo'
        },{
            type: 'separator'
        },{
            label: '剪切',
            accelerator: 'CmdOrCtrl+X',
            role: 'cut'
        },{
            label: '复制',
            accelerator: 'CmdOrCtrl+C',
            role: 'copy'
        },{
            label: '粘贴',
            accelerator: 'CmdOrCtrl+V',
            role: 'paste'
        },{
            label: '全选',
            accelerator: 'CmdOrCtrl+A',
            role: 'selectall'
        }]
    },{
        label: '帮助',
        submenu: [{
            label: '关闭子窗口',
            click: (item,focusedWindow) => {
                if (focusedWindow) {
                    if (focusedWindow.id === 1) {
                        BrowserWindow.getAllWindows().forEach(win => {
                            if (win.id > 1) win.close()
                        })
                    }
                }
            }
        },{
            label: '重新载入资源',
            accelerator: 'CmdOrCtrl+R',
            click: (item,focusedWindow) => {
                if (focusedWindow) {
                    focusedWindow.reload()
                }
            }
        },{
            label: '开发者工具',
            accelerator: 'Ctrl+Shift+I',
            click: (item,focusedWindow) => {
                if (focusedWindow) {
                    focusedWindow.toggleDevTools()
                }
            }
        },{
            type: 'separator'
        },{
            label: '版本 '+version,
            enabled: false
        },{
            label: '主页',
            click: () => {
                shell.openExternal('https://github.com/kagurazakayashi/NyarukoTools')
            }
        },{
            label: '关于',
            click: function (item,focusedWindow) {
                if (focusedWindow) {
                    const options = {
                        type: 'info',
                        title: '关于',
                        buttons: ['知道了'],
                        message: '直播用计时器工具，版本 '+version+'，神楽坂雅詩'
                    }
                    dialog.showMessageBox(focusedWindow,options,function(){})
                }
            }
        }]
    }]
    menu = Menu.buildFromTemplate(menutmp)
}
