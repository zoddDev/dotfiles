'use strict';

let getPath = (() => {
  var _ref2 = _asyncToGenerator(function* (path) {
    if (!allowedAppPaths.has(path)) {
      throw new Error(`${path} is not an allowed app path`);
    }

    return electron.ipcRenderer.invoke(APP_GET_PATH, path);
  });

  return function getPath(_x2) {
    return _ref2.apply(this, arguments);
  };
})();

let setBadgeCount = (() => {
  var _ref3 = _asyncToGenerator(function* (count) {
    electron.ipcRenderer.invoke(APP_SET_BADGE_COUNT, count);
  });

  return function setBadgeCount(_x3) {
    return _ref3.apply(this, arguments);
  };
})();

let dockSetBadge = (() => {
  var _ref4 = _asyncToGenerator(function* (badge) {
    electron.ipcRenderer.invoke(APP_DOCK_SET_BADGE, badge);
  });

  return function dockSetBadge(_x4) {
    return _ref4.apply(this, arguments);
  };
})();

let dockBounce = (() => {
  var _ref5 = _asyncToGenerator(function* (type) {
    return electron.ipcRenderer.invoke(APP_DOCK_BOUNCE, type);
  });

  return function dockBounce(_x5) {
    return _ref5.apply(this, arguments);
  };
})();

let dockCancelBounce = (() => {
  var _ref6 = _asyncToGenerator(function* (id) {
    electron.ipcRenderer.invoke(APP_DOCK_CANCEL_BOUNCE, id);
  });

  return function dockCancelBounce(_x6) {
    return _ref6.apply(this, arguments);
  };
})();

let relaunch = (() => {
  var _ref7 = _asyncToGenerator(function* () {
    electron.ipcRenderer.invoke(APP_RELAUNCH);
  });

  return function relaunch() {
    return _ref7.apply(this, arguments);
  };
})();

let getDefaultDoubleClickAction = (() => {
  var _ref8 = _asyncToGenerator(function* () {
    return electron.ipcRenderer.invoke(APP_GET_DEFAULT_DOUBLE_CLICK_ACTION);
  });

  return function getDefaultDoubleClickAction() {
    return _ref8.apply(this, arguments);
  };
})();

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');
const { UpdaterEvents } = require('../../Constants');

const allowedAppPaths = new Set(['home', 'appData', 'desktop', 'documents', 'downloads']);
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

let releaseChannel = electron.ipcRenderer.sendSync(APP_GET_RELEASE_CHANNEL_SYNC);
let hostVersion = electron.ipcRenderer.sendSync(APP_GET_HOST_VERSION_SYNC);
let moduleVersions = {};

electron.ipcRenderer.invoke(APP_GET_MODULE_VERSIONS).then(versions => {
  moduleVersions = versions;
});

electron.ipcRenderer.on('DISCORD_MODULE_INSTALLED', (() => {
  var _ref = _asyncToGenerator(function* (_) {
    moduleVersions = yield electron.ipcRenderer.invoke(APP_GET_MODULE_VERSIONS);
  });

  return function (_x) {
    return _ref.apply(this, arguments);
  };
})());

function getReleaseChannel() {
  return releaseChannel;
}

function getVersion() {
  return hostVersion;
}

function getModuleVersions() {
  return moduleVersions;
}

module.exports = {
  getReleaseChannel,
  getVersion,
  getModuleVersions,
  getPath,
  setBadgeCount,
  dock: {
    setBadge: dockSetBadge,
    bounce: dockBounce,
    cancelBounce: dockCancelBounce
  },
  relaunch,
  getDefaultDoubleClickAction
};