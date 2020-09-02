'use strict';

let isAccessibilitySupportEnabled = (() => {
  var _ref = _asyncToGenerator(function* () {
    return electron.ipcRenderer.invoke(ACCESSIBILITY_GET_ENABLED);
  });

  return function isAccessibilitySupportEnabled() {
    return _ref.apply(this, arguments);
  };
})();

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');

const { ACCESSIBILITY_GET_ENABLED } = require('../common/constants').IPCEvents;

module.exports = {
  isAccessibilitySupportEnabled
};