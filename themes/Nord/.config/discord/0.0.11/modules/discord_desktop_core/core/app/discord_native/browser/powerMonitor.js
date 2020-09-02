'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');

const {
  POWER_MONITOR_RESUME,
  POWER_MONITOR_SUSPEND,
  POWER_MONITOR_LOCK_SCREEN,
  POWER_MONITOR_UNLOCK_SCREEN,
  POWER_MONITOR_GET_SYSTEM_IDLE_TIME
} = require('../common/constants').IPCEvents;

electron.ipcMain.handle(POWER_MONITOR_GET_SYSTEM_IDLE_TIME, (() => {
  var _ref = _asyncToGenerator(function* (_) {
    return electron.powerMonitor.getSystemIdleTime() * 1000;
  });

  return function (_x) {
    return _ref.apply(this, arguments);
  };
})());

function sendToAllWindows(channel) {
  electron.BrowserWindow.getAllWindows().forEach(win => {
    const contents = win.webContents;
    if (contents != null) {
      contents.send(channel);
    }
  });
}

electron.powerMonitor.on('resume', () => {
  sendToAllWindows(POWER_MONITOR_RESUME);
});

electron.powerMonitor.on('suspend', () => {
  sendToAllWindows(POWER_MONITOR_SUSPEND);
});

electron.powerMonitor.on('lock-screen', () => {
  sendToAllWindows(POWER_MONITOR_LOCK_SCREEN);
});

electron.powerMonitor.on('unlock-screen', () => {
  sendToAllWindows(POWER_MONITOR_UNLOCK_SCREEN);
});