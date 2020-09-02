'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');

const {
  POWER_SAVE_BLOCKER_BLOCK_DISPLAY_SLEEP,
  POWER_SAVE_BLOCKER_UNBLOCK_DISPLAY_SLEEP,
  POWER_SAVE_BLOCKER_CLEANUP_DISPLAY_SLEEP
} = require('../common/constants').IPCEvents;

const powerSaveBlockerIds = new Set();

electron.ipcMain.handle(POWER_SAVE_BLOCKER_BLOCK_DISPLAY_SLEEP, (() => {
  var _ref = _asyncToGenerator(function* (_) {
    const newId = electron.powerSaveBlocker.start('prevent-display-sleep');
    powerSaveBlockerIds.add(newId);
    return newId;
  });

  return function (_x) {
    return _ref.apply(this, arguments);
  };
})());

electron.ipcMain.handle(POWER_SAVE_BLOCKER_UNBLOCK_DISPLAY_SLEEP, (() => {
  var _ref2 = _asyncToGenerator(function* (_, id) {
    electron.powerSaveBlocker.stop(id);
    powerSaveBlockerIds.delete(id);
  });

  return function (_x2, _x3) {
    return _ref2.apply(this, arguments);
  };
})());

electron.ipcMain.handle(POWER_SAVE_BLOCKER_CLEANUP_DISPLAY_SLEEP, (() => {
  var _ref3 = _asyncToGenerator(function* (_) {
    // cleanup all previous sleeps
    for (const id of powerSaveBlockerIds) {
      electron.powerSaveBlocker.stop(id);
    }
    powerSaveBlockerIds.clear();
  });

  return function (_x4) {
    return _ref3.apply(this, arguments);
  };
})());