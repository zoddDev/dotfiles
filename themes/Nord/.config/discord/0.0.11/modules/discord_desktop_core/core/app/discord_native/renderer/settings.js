'use strict';

let get = (() => {
  var _ref = _asyncToGenerator(function* (name, defaultValue) {
    return electron.ipcRenderer.invoke(SETTINGS_GET, name, defaultValue);
  });

  return function get(_x, _x2) {
    return _ref.apply(this, arguments);
  };
})();

let set = (() => {
  var _ref2 = _asyncToGenerator(function* (name, value) {
    return electron.ipcRenderer.invoke(SETTINGS_SET, name, value);
  });

  return function set(_x3, _x4) {
    return _ref2.apply(this, arguments);
  };
})();

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');

const { SETTINGS_GET, SETTINGS_SET, SETTINGS_GET_SYNC } = require('../common/constants').IPCEvents;

function getSync(name, defaultValue) {
  return electron.ipcRenderer.sendSync(SETTINGS_GET_SYNC, name, defaultValue);
}

module.exports = {
  get,
  set,
  getSync
};