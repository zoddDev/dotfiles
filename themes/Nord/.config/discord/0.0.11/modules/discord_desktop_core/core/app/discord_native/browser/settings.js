'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.injectSettingsBackend = injectSettingsBackend;
const electron = require('electron');

const { SETTINGS_GET, SETTINGS_SET, SETTINGS_GET_SYNC } = require('../common/constants').IPCEvents;

let injectedSettings = null;

function getSettings() {
  return injectedSettings != null ? injectedSettings : {
    get: () => {},
    set: () => {},
    save: () => {}
  };
}

function injectSettingsBackend(settings) {
  injectedSettings = settings;
}

electron.ipcMain.handle(SETTINGS_GET, (_, name, defaultValue) => {
  const settings = getSettings();
  return settings.get(name, defaultValue);
});

electron.ipcMain.handle(SETTINGS_SET, (_, name, value) => {
  const settings = getSettings();
  settings.set(name, value);
  settings.save();
});

electron.ipcMain.on(SETTINGS_GET_SYNC, (event, name, defaultValue) => {
  const settings = getSettings();
  event.returnValue = settings.get(name, defaultValue);
});