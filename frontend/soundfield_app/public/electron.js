const electron = require('electron');
const { app, BrowserWindow } = electron;
//const path = require('path');
const isDev = require('electron-is-dev');

let mainWindow = null;
app.on('ready', createWindow);
app.on('window-all-closed', function () {
  if (process.platform !== 'darwin') {
    app.quit()
  }
});
app.on('activate', function () {
  if (mainWindow === null) {
    createWindow()
  }
});

/*
const { ipcMain } = require("electron");
const exec = require('child_process').exec;

ipcMain.on("runScript", (event, data) => {
   exec("node script.js", (error, stdout, stderr) => { 
        console.log(stdout);
    });
    //pipe stuff here
});
*/

function createWindow() {
  mainWindow = new BrowserWindow({
    width: 1024,
    height: 1024,
    title: "SoundField",
    icon: __dirname + "icon.ico"
  });
  mainWindow.loadURL(isDev ? 'http://localhost:3000' : `file://${path.join(__dirname, '../build/index.html')}`);
  mainWindow.on('closed', function () {
    mainWindow = null
  })
  mainWindow.on('page-title-updated', function (e) {
    e.preventDefault()
  });
}