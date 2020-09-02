'use strict';

let flashFrame = (() => {
  var _ref3 = _asyncToGenerator(function* (flag) {
    electron.ipcRenderer.invoke(WINDOW_FLASH_FRAME, flag);
  });

  return function flashFrame(_x3) {
    return _ref3.apply(this, arguments);
  };
})();

let minimize = (() => {
  var _ref4 = _asyncToGenerator(function* (key) {
    electron.ipcRenderer.invoke(WINDOW_MINIMIZE, key);
  });

  return function minimize(_x4) {
    return _ref4.apply(this, arguments);
  };
})();

let restore = (() => {
  var _ref5 = _asyncToGenerator(function* (key) {
    electron.ipcRenderer.invoke(WINDOW_RESTORE, key);
  });

  return function restore(_x5) {
    return _ref5.apply(this, arguments);
  };
})();

let maximize = (() => {
  var _ref6 = _asyncToGenerator(function* (key) {
    electron.ipcRenderer.invoke(WINDOW_MAXIMIZE, key);
  });

  return function maximize(_x6) {
    return _ref6.apply(this, arguments);
  };
})();

let focus = (() => {
  var _ref7 = _asyncToGenerator(function* (_hack, key) {
    electron.ipcRenderer.invoke(WINDOW_FOCUS, key);
  });

  return function focus(_x7, _x8) {
    return _ref7.apply(this, arguments);
  };
})();

let setAlwaysOnTop = (() => {
  var _ref8 = _asyncToGenerator(function* (key, enabled) {
    return electron.ipcRenderer.invoke(WINDOW_SET_ALWAYS_ON_TOP, key, enabled);
  });

  return function setAlwaysOnTop(_x9, _x10) {
    return _ref8.apply(this, arguments);
  };
})();

let isAlwaysOnTop = (() => {
  var _ref9 = _asyncToGenerator(function* (key) {
    return electron.ipcRenderer.invoke(WINDOW_IS_ALWAYS_ON_TOP, key);
  });

  return function isAlwaysOnTop(_x11) {
    return _ref9.apply(this, arguments);
  };
})();

let blur = (() => {
  var _ref10 = _asyncToGenerator(function* (key) {
    electron.ipcRenderer.invoke(WINDOW_BLUR, key);
  });

  return function blur(_x12) {
    return _ref10.apply(this, arguments);
  };
})();

let setProgressBar = (() => {
  var _ref11 = _asyncToGenerator(function* (progress, key) {
    electron.ipcRenderer.invoke(WINDOW_SET_PROGRESS_BAR, key, progress);
  });

  return function setProgressBar(_x13, _x14) {
    return _ref11.apply(this, arguments);
  };
})();

let fullscreen = (() => {
  var _ref12 = _asyncToGenerator(function* (key) {
    electron.ipcRenderer.invoke(WINDOW_TOGGLE_FULLSCREEN, key);
  });

  return function fullscreen(_x15) {
    return _ref12.apply(this, arguments);
  };
})();

let close = (() => {
  var _ref13 = _asyncToGenerator(function* (key) {
    electron.ipcRenderer.invoke(WINDOW_CLOSE, key);
  });

  return function close(_x16) {
    return _ref13.apply(this, arguments);
  };
})();

let setZoomFactor = (() => {
  var _ref14 = _asyncToGenerator(function* (factor) {
    if (!electron.webFrame.setZoomFactor) return;
    electron.webFrame.setZoomFactor(factor / 100);
  });

  return function setZoomFactor(_x17) {
    return _ref14.apply(this, arguments);
  };
})();

let setBackgroundThrottling = (() => {
  var _ref15 = _asyncToGenerator(function* (enabled) {
    electron.ipcRenderer.invoke(WINDOW_SET_BACKGROUND_THROTTLING, enabled);
  });

  return function setBackgroundThrottling(_x18) {
    return _ref15.apply(this, arguments);
  };
})();

let setDevtoolsCallbacks = (() => {
  var _ref16 = _asyncToGenerator(function* (onOpened, onClosed) {
    devtoolsOpenedCallback = onOpened;
    devtoolsClosedCallback = onClosed;
  });

  return function setDevtoolsCallbacks(_x19, _x20) {
    return _ref16.apply(this, arguments);
  };
})();

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');

const {
  WINDOW_BLUR,
  WINDOW_CLOSE,
  WINDOW_FOCUS,
  WINDOW_MAXIMIZE,
  WINDOW_MINIMIZE,
  WINDOW_RESTORE,
  WINDOW_FLASH_FRAME,
  WINDOW_TOGGLE_FULLSCREEN,
  WINDOW_SET_BACKGROUND_THROTTLING,
  WINDOW_SET_PROGRESS_BAR,
  WINDOW_IS_ALWAYS_ON_TOP,
  WINDOW_SET_ALWAYS_ON_TOP,
  WINDOW_DEVTOOLS_OPENED,
  WINDOW_DEVTOOLS_CLOSED
} = require('../common/constants').IPCEvents;

let devtoolsOpenedCallback = () => {};
let devtoolsClosedCallback = () => {};

electron.ipcRenderer.on(WINDOW_DEVTOOLS_OPENED, (() => {
  var _ref = _asyncToGenerator(function* (_) {
    if (devtoolsOpenedCallback != null) {
      devtoolsOpenedCallback();
    }
  });

  return function (_x) {
    return _ref.apply(this, arguments);
  };
})());

electron.ipcRenderer.on(WINDOW_DEVTOOLS_CLOSED, (() => {
  var _ref2 = _asyncToGenerator(function* (_) {
    if (devtoolsOpenedCallback != null) {
      devtoolsOpenedCallback();
    }
  });

  return function (_x2) {
    return _ref2.apply(this, arguments);
  };
})());

module.exports = {
  flashFrame,
  minimize,
  restore,
  maximize,
  focus,
  blur,
  fullscreen,
  close,
  setAlwaysOnTop,
  isAlwaysOnTop,
  setZoomFactor,
  setBackgroundThrottling,
  setProgressBar,
  setDevtoolsCallbacks
};