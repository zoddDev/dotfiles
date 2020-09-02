'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.hasInit = exports.NOTIFICATION_CLICK = exports.events = undefined;
exports.init = init;
exports.close = close;
exports.setMainWindow = setMainWindow;

var _electron = require('electron');

var _fs = require('fs');

var _fs2 = _interopRequireDefault(_fs);

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var _events = require('events');

var _url = require('url');

var _url2 = _interopRequireDefault(_url);

var _ipcMain = require('./ipcMain');

var _ipcMain2 = _interopRequireDefault(_ipcMain);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

// ipcMain events
// TODO: transparency detection?
// TODO: SHQueryUserNotificationState

const IPC_NOTIFICATIONS_CLEAR = 'NOTIFICATIONS_CLEAR';
const IPC_NOTIFICATION_SHOW = 'NOTIFICATION_SHOW';
const IPC_NOTIFICATION_CLICK = 'NOTIFICATION_CLICK';
const IPC_NOTIFICATION_CLOSE = 'NOTIFICATION_CLOSE';

// events
const events = exports.events = new _events.EventEmitter();
const NOTIFICATION_CLICK = exports.NOTIFICATION_CLICK = 'notification-click';

let hasInit = exports.hasInit = false;
const variablesFilePath = _path2.default.join(__dirname, 'notifications', 'variables.json');

let mainWindow;
let title;
let maxVisible;
let screenPosition;
let notifications;
let hideTimeout;
let notificationWindow;
let VARIABLES;

function webContentsSend(win, event, ...args) {
  if (win != null && win.webContents != null) {
    win.webContents.send(`DISCORD_${event}`, ...args);
  }
}

function init({
  mainWindow: _mainWindow,
  title: _title,
  maxVisible: _maxVisible,
  screenPosition: _screenPosition
}) {
  if (hasInit) {
    console.warn('notificationScreen: Has already init! Cancelling init.');
    return;
  }
  exports.hasInit = hasInit = true;

  VARIABLES = JSON.parse(_fs2.default.readFileSync(variablesFilePath));

  mainWindow = _mainWindow;

  title = _title;
  maxVisible = _maxVisible;
  screenPosition = _screenPosition;
  notifications = [];
  hideTimeout = null;

  _ipcMain2.default.on(IPC_NOTIFICATIONS_CLEAR, handleNotificationsClear);
  _ipcMain2.default.on(IPC_NOTIFICATION_SHOW, handleNotificationShow);
  _ipcMain2.default.on(IPC_NOTIFICATION_CLICK, handleNotificationClick);
  _ipcMain2.default.on(IPC_NOTIFICATION_CLOSE, handleNotificationClose);
}

function destroyWindow() {
  if (notificationWindow == null) return;

  notificationWindow.hide();
  notificationWindow.close();
  notificationWindow = null;
}

function close() {
  mainWindow = null;

  destroyWindow();

  _ipcMain2.default.removeListener(IPC_NOTIFICATIONS_CLEAR, handleNotificationsClear);
  _ipcMain2.default.removeListener(IPC_NOTIFICATION_SHOW, handleNotificationShow);
  _ipcMain2.default.removeListener(IPC_NOTIFICATION_CLICK, handleNotificationClick);
  _ipcMain2.default.removeListener(IPC_NOTIFICATION_CLOSE, handleNotificationClose);
}

function setMainWindow(_mainWindow) {
  mainWindow = _mainWindow;
}

function handleNotificationsClear() {
  notifications = [];
  updateNotifications();
}

function handleNotificationShow(e, notification) {
  notifications.push(notification);
  updateNotifications();
}

function handleNotificationClick(e, notificationId) {
  webContentsSend(mainWindow, IPC_NOTIFICATION_CLICK, notificationId);
  events.emit(NOTIFICATION_CLICK);
}

function handleNotificationClose(e, notificationId) {
  if (notificationWindow) {
    webContentsSend(notificationWindow, 'FADE_OUT', notificationId);
  }
  setTimeout(() => {
    notifications = notifications.filter(notification => notification.id !== notificationId);
    updateNotifications();
  }, VARIABLES.outDuration);
}

function updateNotifications() {
  if (notifications.length > 0) {
    clearTimeout(hideTimeout);
    hideTimeout = null;

    if (notificationWindow != null) {
      const { width, height, x, y } = calculateBoundingBox();
      // [adill] this order is important. if you setPosition before you setSize electron
      // incorrectly computes the window size. i haven't investigated the root cause
      // further than this observation.
      notificationWindow.setSize(width, height);
      notificationWindow.setPosition(x, y);
      notificationWindow.showInactive();
    } else {
      createWindow();
      return;
    }
  } else if (hideTimeout == null) {
    hideTimeout = setTimeout(() => destroyWindow(), VARIABLES.outDuration * 1.1);
  }

  if (notificationWindow != null) {
    webContentsSend(notificationWindow, 'UPDATE', notifications.slice(0, maxVisible));
  }
}

function calculateBoundingBox() {
  const [positionX, positionY] = mainWindow.getPosition();
  const [windowWidth, windowHeight] = mainWindow.getSize();
  const centerPoint = {
    x: Math.round(positionX + windowWidth / 2),
    y: Math.round(positionY + windowHeight / 2)
  };

  const activeDisplay = _electron.screen.getDisplayNearestPoint(centerPoint) || _electron.screen.getPrimaryDisplay();
  const workArea = activeDisplay.workArea;

  const width = VARIABLES.width;
  const height = maxVisible * VARIABLES.height;

  const x = workArea.x + workArea.width - width;
  let y;
  switch (screenPosition) {
    case 'top':
      y = workArea.y;
      break;
    case 'bottom':
      y = workArea.y + workArea.height - height;
      break;
  }

  return { x, y, width, height };
}

function createWindow() {
  if (notificationWindow != null) {
    return;
  }

  notificationWindow = new _electron.BrowserWindow({
    title: title,
    frame: false,
    resizable: false,
    show: false,
    acceptFirstMouse: true,
    alwaysOnTop: true,
    skipTaskbar: true,
    transparent: true,
    webPreferences: {
      nodeIntegration: true
    }
  });
  const notificationUrl = _url2.default.format({
    protocol: 'file',
    slashes: true,
    pathname: _path2.default.join(__dirname, 'notifications', 'index.html')
  });
  notificationWindow.loadURL(notificationUrl);
  notificationWindow.webContents.on('did-finish-load', () => updateNotifications());
}