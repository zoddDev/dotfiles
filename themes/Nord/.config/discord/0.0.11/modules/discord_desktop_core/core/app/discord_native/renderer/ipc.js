'use strict';

const electron = require('electron');
const { getDiscordIPCEvent } = require('../common/constants');

const ipcRenderer = electron.ipcRenderer;

function send(ev, ...args) {
  ipcRenderer.send(getDiscordIPCEvent(ev), ...args);
}

function on(ev, callback) {
  ipcRenderer.on(getDiscordIPCEvent(ev), callback);
}

module.exports = {
  send,
  on
};