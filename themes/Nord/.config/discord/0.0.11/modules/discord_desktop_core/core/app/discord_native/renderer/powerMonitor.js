'use strict';

let getSystemIdleTimeMs = (() => {
  var _ref = _asyncToGenerator(function* () {
    return electron.ipcRenderer.invoke(POWER_MONITOR_GET_SYSTEM_IDLE_TIME);
  });

  return function getSystemIdleTimeMs() {
    return _ref.apply(this, arguments);
  };
})();

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');
const EventEmitter = require('events');

const {
  POWER_MONITOR_RESUME,
  POWER_MONITOR_SUSPEND,
  POWER_MONITOR_LOCK_SCREEN,
  POWER_MONITOR_UNLOCK_SCREEN,
  POWER_MONITOR_GET_SYSTEM_IDLE_TIME
} = require('../common/constants').IPCEvents;

const events = new EventEmitter();

electron.ipcRenderer.on(POWER_MONITOR_RESUME, () => {
  events.emit('resume');
});

electron.ipcRenderer.on(POWER_MONITOR_SUSPEND, () => {
  events.emit('suspend');
});

electron.ipcRenderer.on(POWER_MONITOR_LOCK_SCREEN, () => {
  events.emit('lock-screen');
});

electron.ipcRenderer.on(POWER_MONITOR_UNLOCK_SCREEN, () => {
  events.emit('unlock-screen');
});

function on() {
  events.on.apply(events, arguments);
}

function removeListener() {
  events.removeListener.apply(events, arguments);
}

function removeAllListeners() {
  events.removeAllListeners.apply(events, arguments);
}

module.exports = {
  on,
  removeListener,
  removeAllListeners,
  getSystemIdleTimeMs
};