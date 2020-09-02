'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _electron = require('electron');

exports.default = {
  on: (event, callback) => _electron.ipcMain.on(`DISCORD_${event}`, callback),
  removeListener: (event, callback) => _electron.ipcMain.removeListener(`DISCORD_${event}`, callback),
  reply: (event, channel, ...args) => event.sender.send(`DISCORD_${channel}`, ...args)
};
module.exports = exports.default;