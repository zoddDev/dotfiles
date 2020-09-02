'use strict';

let setEnableHardwareAcceleration = (() => {
  var _ref = _asyncToGenerator(function* (enable) {
    electron.ipcRenderer.invoke(GPU_SETTINGS_SET_ENABLE_HWACCEL, enable);
  });

  return function setEnableHardwareAcceleration(_x) {
    return _ref.apply(this, arguments);
  };
})();

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');

const { GPU_SETTINGS_SET_ENABLE_HWACCEL, GPU_SETTINGS_GET_ENABLE_HWACCEL_SYNC } = require('../common/constants').IPCEvents;

const hardwareAccelerationEnabled = electron.ipcRenderer.sendSync(GPU_SETTINGS_GET_ENABLE_HWACCEL_SYNC);

function getEnableHardwareAcceleration() {
  return hardwareAccelerationEnabled;
}

module.exports = {
  getEnableHardwareAcceleration,
  setEnableHardwareAcceleration
};