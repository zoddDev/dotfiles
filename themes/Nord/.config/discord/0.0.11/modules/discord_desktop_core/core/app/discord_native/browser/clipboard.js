'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');

const { CLIPBOARD_COPY, CLIPBOARD_CUT, CLIPBOARD_PASTE } = require('../common/constants').IPCEvents;

electron.ipcMain.handle(CLIPBOARD_COPY, (() => {
  var _ref = _asyncToGenerator(function* (_) {
    electron.webContents.getFocusedWebContents().copy();
  });

  return function (_x) {
    return _ref.apply(this, arguments);
  };
})());

electron.ipcMain.handle(CLIPBOARD_CUT, (() => {
  var _ref2 = _asyncToGenerator(function* (_) {
    electron.webContents.getFocusedWebContents().cut();
  });

  return function (_x2) {
    return _ref2.apply(this, arguments);
  };
})());

electron.ipcMain.handle(CLIPBOARD_PASTE, (() => {
  var _ref3 = _asyncToGenerator(function* (_) {
    electron.webContents.getFocusedWebContents().paste();
  });

  return function (_x3) {
    return _ref3.apply(this, arguments);
  };
})());