'use strict';

let blockDisplaySleep = (() => {
  var _ref = _asyncToGenerator(function* () {
    return electron.ipcRenderer.invoke(POWER_SAVE_BLOCKER_BLOCK_DISPLAY_SLEEP);
  });

  return function blockDisplaySleep() {
    return _ref.apply(this, arguments);
  };
})();

let unblockDisplaySleep = (() => {
  var _ref2 = _asyncToGenerator(function* (id) {
    return electron.ipcRenderer.invoke(POWER_SAVE_BLOCKER_UNBLOCK_DISPLAY_SLEEP, id);
  });

  return function unblockDisplaySleep(_x) {
    return _ref2.apply(this, arguments);
  };
})();

let cleanupDisplaySleep = (() => {
  var _ref3 = _asyncToGenerator(function* () {
    return electron.ipcRenderer.invoke(POWER_SAVE_BLOCKER_CLEANUP_DISPLAY_SLEEP);
  });

  return function cleanupDisplaySleep() {
    return _ref3.apply(this, arguments);
  };
})();

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');

const {
  POWER_SAVE_BLOCKER_BLOCK_DISPLAY_SLEEP,
  POWER_SAVE_BLOCKER_UNBLOCK_DISPLAY_SLEEP,
  POWER_SAVE_BLOCKER_CLEANUP_DISPLAY_SLEEP
} = require('../common/constants').IPCEvents;

module.exports = {
  blockDisplaySleep,
  unblockDisplaySleep,
  cleanupDisplaySleep
};