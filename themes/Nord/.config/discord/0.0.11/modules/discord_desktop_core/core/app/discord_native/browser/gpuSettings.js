'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.injectGpuSettingsBackend = injectGpuSettingsBackend;

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');

const {
  GPU_SETTINGS_SET_ENABLE_HWACCEL,
  GPU_SETTINGS_GET_ENABLE_HWACCEL_SYNC
} = require('../common/constants').IPCEvents;

let injectedGpuSettings = null;

function injectGpuSettingsBackend(gpuSettings) {
  injectedGpuSettings = gpuSettings;
}

electron.ipcMain.handle(GPU_SETTINGS_SET_ENABLE_HWACCEL, (() => {
  var _ref = _asyncToGenerator(function* (_, enable) {
    if (injectedGpuSettings) {
      injectedGpuSettings.setEnableHardwareAcceleration(enable);
    }
  });

  return function (_x, _x2) {
    return _ref.apply(this, arguments);
  };
})());

electron.ipcMain.on(GPU_SETTINGS_GET_ENABLE_HWACCEL_SYNC, event => {
  event.returnValue = injectedGpuSettings != null ? injectedGpuSettings.getEnableHardwareAcceleration() : false;
});