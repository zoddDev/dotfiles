'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.hasInit = undefined;
exports.init = init;

var _autoStart = require('./autoStart');

var autoStart = _interopRequireWildcard(_autoStart);

var _appSettings = require('./appSettings');

var _ipcMain = require('./ipcMain');

var _ipcMain2 = _interopRequireDefault(_ipcMain);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

const settings = (0, _appSettings.getSettings)();
const NOOP = () => {};

let hasInit = exports.hasInit = false;

function init() {
  if (hasInit) {
    console.warn('appConfig: Has already init! Cancelling init.');
    return;
  }
  exports.hasInit = hasInit = true;

  _ipcMain2.default.on('TOGGLE_MINIMIZE_TO_TRAY', (_event, value) => setMinimizeOnClose(value));
  _ipcMain2.default.on('TOGGLE_OPEN_ON_STARTUP', (_event, value) => toggleRunOnStartup(value));
  _ipcMain2.default.on('TOGGLE_START_MINIMIZED', (_event, value) => toggleStartMinimized(value));
}

function setMinimizeOnClose(minimizeToTray) {
  settings.set('MINIMIZE_TO_TRAY', minimizeToTray);
}

function toggleRunOnStartup(openOnStartup) {
  settings.set('OPEN_ON_STARTUP', openOnStartup);

  if (openOnStartup) {
    autoStart.install(NOOP);
  } else {
    autoStart.uninstall(NOOP);
  }
}

function toggleStartMinimized(startMinimized) {
  settings.set('START_MINIMIZED', startMinimized);
  autoStart.isInstalled(installed => {
    // Only update the registry for this toggle if the app was already set to autorun
    if (installed) {
      autoStart.install(NOOP);
    }
  });
}