'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.hasInit = undefined;
exports.init = init;

var _electron = require('electron');

var _utils = require('./utils');

var _mainScreen = require('./mainScreen');

var _ipcMain = require('./ipcMain');

var _ipcMain2 = _interopRequireDefault(_ipcMain);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

let hasInit = exports.hasInit = false;

let lastIndex;
let appIcons;

/**
 * Used on Windows to set the taskbar icon
 */
function init() {
  // Only init on win32 platforms
  if (process.platform !== 'win32') return;

  if (hasInit) {
    console.warn('appBadge: Has already init! Cancelling init.');
    return;
  }
  exports.hasInit = hasInit = true;

  lastIndex = null;
  appIcons = [];

  const resourcePath = `app/images/badges`;

  for (let i = 1; i <= 11; i++) {
    appIcons.push((0, _utils.exposeModuleResource)(resourcePath, `badge-${i}.ico`));
  }

  _ipcMain2.default.on('APP_BADGE_SET', (_event, count) => setAppBadge(count));
}

function setAppBadge(count) {
  const win = _electron.BrowserWindow.fromId((0, _mainScreen.getMainWindowId)());

  const { index, description } = getOverlayIconData(count);

  // Prevent setting a new icon when the icon is the same
  if (lastIndex !== index) {
    if (index == null) {
      win.setOverlayIcon(null, description);
    } else {
      win.setOverlayIcon(appIcons[index], description);
    }

    lastIndex = index;
  }
}

/*
 * -1 is bullet
 * 0 is nothing
 * 1-9 is a number badge
 * 10+ is `9+`
 */
function getOverlayIconData(count) {
  // Unread message badge
  if (count === -1) {
    return {
      index: 10, // this.appIcons.length - 1
      description: `Unread messages`
    };
  }

  // Clear overlay icon
  if (count === 0) {
    return {
      index: null, // null is used to clear the overlay icon
      description: 'No Notifications'
    };
  }

  // Notification badge
  const index = Math.max(1, Math.min(count, 10)) - 1; // arrays are 0 based
  return {
    index,
    description: `${index} notifications`
  };
}