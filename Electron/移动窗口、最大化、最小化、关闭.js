/*
 * main.js
*/

import { app, BrowserWindow, ipcMain } from "electron"; // +ipcMain

//  mainWindow = new BrowserWindow ...... });
ipcMain.on('WindowToMinimize', function () {
    mainWindow.minimize();
})
ipcMain.on('windowToMaximize', function () {
    if (mainWindow.isMaximized()) {
        mainWindow.restore();
    } else {
        mainWindow.maximize();
    }
})
ipcMain.on('WindowToClose', function () {
    mainWindow.close();
})
mainWindow.on('maximize', function () {
    mainWindow.webContents.send('WindowDidMaximize');
})
mainWindow.on('unmaximize', function () {
    mainWindow.webContents.send('WindowDidUnMaximize');
})
// mainWindow.loadFile(path.join(__dirname, "../index.html") ......


/*
 * renderer.js
*/

// const { ipcRenderer } = window.require('electron'); ......
const windowSystemBtnMax = document.getElementById('windowSystemBtnMax');
if (windowSystemBtnMax) {
    windowSystemBtnMax.addEventListener('click', () => {
        ipcRenderer.send('windowToMaximize');
    });
    ipcRenderer.on('WindowDidMaximize', (event) => {
        windowSystemBtnMax.innerHTML = '<span class="material-icons">fullscreen_exit</span>';
    });
    ipcRenderer.on('WindowDidUnMaximize', (event) => {
        windowSystemBtnMax.innerHTML = '<span class="material-icons">fullscreen</span>';
    });
}

const windowSystemBtnMin = document.getElementById('windowSystemBtnMin');
if (windowSystemBtnMin) {
    windowSystemBtnMin.addEventListener('click', () => {
        ipcRenderer.send('WindowToMinimize');
    })
}

const windowSystemBtnClose = document.getElementById('windowSystemBtnClose');
if (windowSystemBtnClose) {
    windowSystemBtnClose.addEventListener('click', () => {
        ipcRenderer.send('WindowToClose');
    })
}

/*
index.html

<button class="windowSystemBtn colorMenu" type="button" id="windowSystemBtnMin"><span class="material-icons">remove</span></button>
<button class="windowSystemBtn colorMenu" type="button" id="windowSystemBtnMax"><span class="material-icons">fullscreen</span></button>
<button class="windowSystemBtn colorMenu" type="button" id="windowSystemBtnClose"><span class="material-icons">close</span></button>
*/