'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.injectGetWindow = injectGetWindow;

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');
const process = require('process');

const {
  WINDOW_BLUR,
  WINDOW_CLOSE,
  WINDOW_FOCUS,
  WINDOW_MAXIMIZE,
  WINDOW_MINIMIZE,
  WINDOW_RESTORE,
  WINDOW_FLASH_FRAME,
  WINDOW_TOGGLE_FULLSCREEN,
  WINDOW_SET_BACKGROUND_THROTTLING,
  WINDOW_SET_PROGRESS_BAR,
  WINDOW_IS_ALWAYS_ON_TOP,
  WINDOW_SET_ALWAYS_ON_TOP
} = require('../common/constants').IPCEvents;

let injectedGetWindow = _key => {
  return null;
};

function injectGetWindow(getWindow) {
  injectedGetWindow = getWindow;
}

electron.ipcMain.handle(WINDOW_FLASH_FRAME, (() => {
  var _ref = _asyncToGenerator(function* (_, flag) {
    const currentWindow = injectedGetWindow();
    if (currentWindow == null || currentWindow.flashFrame == null) return;
    currentWindow.flashFrame(!currentWindow.isFocused() && flag);
  });

  return function (_x, _x2) {
    return _ref.apply(this, arguments);
  };
})());

electron.ipcMain.handle(WINDOW_MINIMIZE, (() => {
  var _ref2 = _asyncToGenerator(function* (_, key) {
    const win = injectedGetWindow(key);
    if (win == null) return;
    win.minimize();
  });

  return function (_x3, _x4) {
    return _ref2.apply(this, arguments);
  };
})());

electron.ipcMain.handle(WINDOW_RESTORE, (() => {
  var _ref3 = _asyncToGenerator(function* (_, key) {
    const win = injectedGetWindow(key);
    if (win == null) return;
    win.restore();
  });

  return function (_x5, _x6) {
    return _ref3.apply(this, arguments);
  };
})());

electron.ipcMain.handle(WINDOW_MAXIMIZE, (() => {
  var _ref4 = _asyncToGenerator(function* (_, key) {
    const win = injectedGetWindow(key);
    if (win == null) return;
    if (win.isMaximized()) {
      win.unmaximize();
    } else {
      win.maximize();
    }
  });

  return function (_x7, _x8) {
    return _ref4.apply(this, arguments);
  };
})());

electron.ipcMain.handle(WINDOW_FOCUS, (() => {
  var _ref5 = _asyncToGenerator(function* (_, key) {
    const win = injectedGetWindow(key);
    if (win == null) return;
    win.show();
  });

  return function (_x9, _x10) {
    return _ref5.apply(this, arguments);
  };
})());

electron.ipcMain.handle(WINDOW_SET_ALWAYS_ON_TOP, (() => {
  var _ref6 = _asyncToGenerator(function* (_, key, enabled) {
    const win = injectedGetWindow(key);
    if (win == null) return;
    win.setAlwaysOnTop(enabled);
  });

  return function (_x11, _x12, _x13) {
    return _ref6.apply(this, arguments);
  };
})());

electron.ipcMain.handle(WINDOW_IS_ALWAYS_ON_TOP, (() => {
  var _ref7 = _asyncToGenerator(function* (_, key) {
    const win = injectedGetWindow(key);
    if (win == null) return false;
    return win.isAlwaysOnTop();
  });

  return function (_x14, _x15) {
    return _ref7.apply(this, arguments);
  };
})());

electron.ipcMain.handle(WINDOW_BLUR, (() => {
  var _ref8 = _asyncToGenerator(function* (_, key) {
    const win = injectedGetWindow(key);
    if (win != null && !win.isDestroyed()) {
      win.blur();
    }
  });

  return function (_x16, _x17) {
    return _ref8.apply(this, arguments);
  };
})());

electron.ipcMain.handle(WINDOW_SET_PROGRESS_BAR, (() => {
  var _ref9 = _asyncToGenerator(function* (_, key, progress) {
    const win = injectedGetWindow(key);
    if (win == null) return;
    win.setProgressBar(progress);
  });

  return function (_x18, _x19, _x20) {
    return _ref9.apply(this, arguments);
  };
})());

electron.ipcMain.handle(WINDOW_TOGGLE_FULLSCREEN, (() => {
  var _ref10 = _asyncToGenerator(function* (_, key) {
    const currentWindow = injectedGetWindow(key);
    currentWindow.setFullScreen(!currentWindow.isFullScreen());
  });

  return function (_x21, _x22) {
    return _ref10.apply(this, arguments);
  };
})());

electron.ipcMain.handle(WINDOW_CLOSE, (() => {
  var _ref11 = _asyncToGenerator(function* (_, key) {
    if (key == null && process.platform === 'darwin') {
      electron.Menu.sendActionToFirstResponder('hide:');
    } else {
      const win = injectedGetWindow(key);
      if (win == null) return;
      win.close();
    }
  });

  return function (_x23, _x24) {
    return _ref11.apply(this, arguments);
  };
})());

electron.ipcMain.handle(WINDOW_SET_BACKGROUND_THROTTLING, (() => {
  var _ref12 = _asyncToGenerator(function* (_, enabled) {
    const win = injectedGetWindow();
    if (win == null) return;
    win.webContents.setBackgroundThrottling(enabled);
  });

  return function (_x25, _x26) {
    return _ref12.apply(this, arguments);
  };
})());