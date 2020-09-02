'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _electron = require('electron');

const menu = require('./' + process.platform);

exports.default = _electron.Menu.buildFromTemplate(menu);
module.exports = exports.default;