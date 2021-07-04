// In renderer process B
ipcRenderer.send('message', 'someArgs')

// In the main process.
ipcMain.on('message', (event, arg) => {
  rendererAWindow.webContents.send('message', arg);
})

// In renderer process A
ipcRenderer.on('messaget', (event, arg) => {
    // do something
})
