'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.injectBuildInfo = injectBuildInfo;
exports.injectModuleUpdater = injectModuleUpdater;

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');

const {
  APP_GET_RELEASE_CHANNEL_SYNC,
  APP_GET_HOST_VERSION_SYNC,
  APP_GET_MODULE_VERSIONS,
  APP_GET_PATH,
  APP_SET_BADGE_COUNT,
  APP_DOCK_SET_BADGE,
  APP_DOCK_BOUNCE,
  APP_DOCK_CANCEL_BOUNCE,
  APP_RELAUNCH,
  APP_GET_DEFAULT_DOUBLE_CLICK_ACTION
} = require('../common/constants').IPCEvents;

let injectedBuildInfo = null;
let injectedModuleUpdater = null;

function injectBuildInfo(buildInfo) {
  injectedBuildInfo = buildInfo;
}

function injectModuleUpdater(moduleUpdater) {
  injectedModuleUpdater = moduleUpdater;
}

electron.ipcMain.on(APP_GET_RELEASE_CHANNEL_SYNC, event => {
  event.returnValue = injectedBuildInfo.releaseChannel;
});

electron.ipcMain.on(APP_GET_HOST_VERSION_SYNC, event => {
  event.returnValue = electron.app.getVersion();
});

electron.ipcMain.handle(APP_GET_MODULE_VERSIONS, (() => {
  var _ref = _asyncToGenerator(function* (_) {
    const versions = {};
    const installed = injectedModuleUpdater != null ? injectedModuleUpdater.getInstalled() : {};
    for (const name of Object.keys(installed)) {
      versions[name] = installed[name].installedVersion;
    }
    return versions;
  });

  return function (_x) {
    return _ref.apply(this, arguments);
  };
})());

electron.ipcMain.handle(APP_GET_PATH, (() => {
  var _ref2 = _asyncToGenerator(function* (_, path) {
    return electron.app.getPath(path);
  });

  return function (_x2, _x3) {
    return _ref2.apply(this, arguments);
  };
})());

electron.ipcMain.handle(APP_SET_BADGE_COUNT, (() => {
  var _ref3 = _asyncToGenerator(function* (_, count) {
    electron.app.setBadgeCount(count);
  });

  return function (_x4, _x5) {
    return _ref3.apply(this, arguments);
  };
})());

electron.ipcMain.handle(APP_DOCK_SET_BADGE, (() => {
  var _ref4 = _asyncToGenerator(function* (_, badge) {
    if (electron.app.dock != null) {
      electron.app.dock.setBadge(badge);
    }
  });

  return function (_x6, _x7) {
    return _ref4.apply(this, arguments);
  };
})());

electron.ipcMain.handle(APP_DOCK_BOUNCE, (() => {
  var _ref5 = _asyncToGenerator(function* (_, type) {
    if (electron.app.dock != null) {
      return electron.app.dock.bounce(type);
    } else {
      return -1;
    }
  });

  return function (_x8, _x9) {
    return _ref5.apply(this, arguments);
  };
})());

electron.ipcMain.handle(APP_DOCK_CANCEL_BOUNCE, (() => {
  var _ref6 = _asyncToGenerator(function* (_, id) {
    if (electron.app.dock != null) {
      electron.app.dock.cancelBounce(id);
    }
  });

  return function (_x10, _x11) {
    return _ref6.apply(this, arguments);
  };
})());

electron.ipcMain.handle(APP_RELAUNCH, (() => {
  var _ref7 = _asyncToGenerator(function* (_) {
    electron.app.relaunch();
    electron.app.exit(0);
  });

  return function (_x12) {
    return _ref7.apply(this, arguments);
  };
})());

electron.ipcMain.handle(APP_GET_DEFAULT_DOUBLE_CLICK_ACTION, (() => {
  var _ref8 = _asyncToGenerator(function* (_) {
    return electron.systemPreferences.getUserDefault('AppleActionOnDoubleClick', 'string');
  });

  return function (_x13) {
    return _ref8.apply(this, arguments);
  };
})());