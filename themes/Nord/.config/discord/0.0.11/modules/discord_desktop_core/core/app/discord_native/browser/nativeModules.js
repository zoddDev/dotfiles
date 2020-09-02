'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.injectModuleUpdater = injectModuleUpdater;

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');
const { once } = require('events');

const { NATIVE_MODULES_GET_PATHS, NATIVE_MODULES_INSTALL } = require('../common/constants').IPCEvents;

let injectedModuleUpdater = null;

function injectModuleUpdater(moduleUpdater) {
  injectedModuleUpdater = moduleUpdater;
}

electron.ipcMain.on(NATIVE_MODULES_GET_PATHS, event => {
  event.returnValue = {
    mainAppDirname: global.mainAppDirname,
    browserModulePaths: require('module').globalPaths
  };
});

electron.ipcMain.handle(NATIVE_MODULES_INSTALL, (() => {
  var _ref = _asyncToGenerator(function* (_, moduleName) {
    const updater = injectedModuleUpdater;
    if (!updater) {
      throw new Error('Module updater is not available!');
    }

    const waitForInstall = new Promise(function (resolve, reject) {
      let installedHandler = function (installedModuleEvent) {
        if (installedModuleEvent.name === moduleName) {
          updater.events.removeListener(updater.INSTALLED_MODULE, installedHandler);
          if (installedModuleEvent.succeeded) {
            resolve();
          } else {
            reject(new Error(`Failed to install ${moduleName}`));
          }
        }
      };

      updater.events.on(updater.INSTALLED_MODULE, installedHandler);
    });

    updater.install(moduleName, false);
    yield waitForInstall;
  });

  return function (_x, _x2) {
    return _ref.apply(this, arguments);
  };
})());