'use strict';

let ensureModule = (() => {
  var _ref = _asyncToGenerator(function* (name) {
    let modulePromise = modulePromises[name];
    if (modulePromise == null) {
      modulePromise = electron.ipcRenderer.invoke(NATIVE_MODULES_INSTALL, name);
    }
    return modulePromise;
  });

  return function ensureModule(_x) {
    return _ref.apply(this, arguments);
  };
})();

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');
const vm = require('vm');

const { NATIVE_MODULES_GET_PATHS, NATIVE_MODULES_INSTALL } = require('../common/constants').IPCEvents;

const modulePromises = {};

function getSanitizedModulePaths() {
  let sanitizedModulePaths = [];

  const { mainAppDirname, browserModulePaths } = electron.ipcRenderer.sendSync(NATIVE_MODULES_GET_PATHS);

  browserModulePaths.forEach(modulePath => {
    if (!modulePath.includes('electron.asar')) {
      sanitizedModulePaths.push(modulePath);
    }
  });

  const rendererModulePaths = require('module')._nodeModulePaths(mainAppDirname);
  sanitizedModulePaths = sanitizedModulePaths.concat(rendererModulePaths.slice(0, 2));

  return sanitizedModulePaths;
}

function requireModule(name) {
  if (!/^discord_[a-z0-9_-]+$/.test(name) && name !== 'erlpack') {
    throw new Error('"' + String(name) + '" is not a whitelisted native module');
  }
  return require(name);
}

module.paths = getSanitizedModulePaths();
module.exports = {
  ensureModule,
  requireModule
};