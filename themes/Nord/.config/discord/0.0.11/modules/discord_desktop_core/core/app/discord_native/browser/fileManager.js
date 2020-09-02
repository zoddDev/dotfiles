'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');

const {
  FILE_MANAGER_GET_MODULE_PATH,
  FILE_MANAGER_SHOW_SAVE_DIALOG,
  FILE_MANAGER_SHOW_OPEN_DIALOG,
  FILE_MANAGER_SHOW_ITEM_IN_FOLDER
} = require('../common/constants').IPCEvents;

electron.ipcMain.handle(FILE_MANAGER_GET_MODULE_PATH, (() => {
  var _ref = _asyncToGenerator(function* (_) {
    return global.modulePath;
  });

  return function (_x) {
    return _ref.apply(this, arguments);
  };
})());

electron.ipcMain.handle(FILE_MANAGER_SHOW_SAVE_DIALOG, (() => {
  var _ref2 = _asyncToGenerator(function* (_, dialogOptions) {
    return yield electron.dialog.showSaveDialog(dialogOptions);
  });

  return function (_x2, _x3) {
    return _ref2.apply(this, arguments);
  };
})());

electron.ipcMain.handle(FILE_MANAGER_SHOW_OPEN_DIALOG, (() => {
  var _ref3 = _asyncToGenerator(function* (_, dialogOptions) {
    return yield electron.dialog.showOpenDialog(dialogOptions);
  });

  return function (_x4, _x5) {
    return _ref3.apply(this, arguments);
  };
})());

electron.ipcMain.handle(FILE_MANAGER_SHOW_ITEM_IN_FOLDER, (() => {
  var _ref4 = _asyncToGenerator(function* (_, path) {
    electron.shell.showItemInFolder(path);
  });

  return function (_x6, _x7) {
    return _ref4.apply(this, arguments);
  };
})());