'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _electron = require('electron');

var _securityUtils = require('../../common/securityUtils');

var _Constants = require('../Constants');

var Constants = _interopRequireWildcard(_Constants);

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

const { MenuEvents } = Constants;
const SEPARATOR = { type: 'separator' };

function getWindow() {
  let window = _electron.BrowserWindow.getFocusedWindow();
  if (!window) {
    const windowList = _electron.BrowserWindow.getAllWindows();
    if (windowList && windowList[0]) {
      window = windowList[0];
      window.show();
      window.focus();
    }
  }
  return window;
}

exports.default = [{
  label: 'Discord',
  submenu: [{
    label: 'About Discord',
    selector: 'orderFrontStandardAboutPanel:'
  }, {
    label: 'Check for Updates...',
    click: () => _electron.app.emit(MenuEvents.CHECK_FOR_UPDATES)
  }, {
    label: 'Acknowledgements',
    click: () => (0, _securityUtils.saferShellOpenExternal)('https://discord.com/acknowledgements')
  }, SEPARATOR, {
    label: 'Preferences',
    click: () => _electron.app.emit(MenuEvents.OPEN_SETTINGS),
    accelerator: 'Command+,'
  }, SEPARATOR, {
    label: 'Services',
    submenu: []
  }, SEPARATOR, {
    label: 'Hide Discord',
    selector: 'hide:',
    accelerator: 'Command+H'
  }, {
    label: 'Hide Others',
    selector: 'hideOtherApplications:',
    accelerator: 'Command+Alt+H'
  }, {
    label: 'Show All',
    selector: 'unhideAllApplications:'
  }, SEPARATOR, {
    label: 'Quit',
    click: () => _electron.app.quit(),
    accelerator: 'Command+Q'
  }]
}, {
  label: 'Edit',
  submenu: [{
    role: 'undo',
    accelerator: 'Command+Z'
  }, {
    role: 'redo',
    accelerator: 'Shift+Command+Z'
  }, SEPARATOR, {
    role: 'cut',
    accelerator: 'Command+X'
  }, {
    role: 'copy',
    accelerator: 'Command+C'
  }, {
    role: 'paste',
    accelerator: 'Command+V'
  }, {
    role: 'selectAll',
    accelerator: 'Command+A'
  }]
}, {
  label: 'View',
  submenu: [{
    label: 'Reload',
    click: () => {
      const window = getWindow();
      if (window) {
        window.webContents.reloadIgnoringCache();
      }
    },
    accelerator: 'Command+R'
  }, {
    label: 'Toggle Full Screen',
    click: () => {
      const window = getWindow();
      if (window) {
        window.setFullScreen(!window.isFullScreen());
      }
    },
    accelerator: 'Command+Control+F'
  }, SEPARATOR, {
    label: 'Developer',
    submenu: [{
      label: 'Toggle Developer Tools',
      click: () => {
        const window = getWindow();
        if (window) {
          window.toggleDevTools();
        }
      },
      accelerator: 'Alt+Command+I'
    }]
  }]
}, {
  label: 'Window',
  submenu: [{
    label: 'Minimize',
    selector: 'performMiniaturize:',
    accelerator: 'Command+M'
  }, {
    label: 'Zoom',
    selector: 'performZoom:'
  }, {
    label: 'Close',
    accelerator: 'Command+W',
    click: (_, window) => {
      // Main window
      if (window.windowKey == null) {
        _electron.Menu.sendActionToFirstResponder('hide:');
      } else {
        window.close();
      }
    }
  }, SEPARATOR, {
    label: 'Bring All to Front',
    selector: 'arrangeInFront:'
  }]
}, {
  label: 'Help',
  submenu: [{
    label: 'Discord Help',
    click: () => _electron.app.emit(MenuEvents.OPEN_HELP)
  }]
}];
module.exports = exports.default;