'use strict';

const os = require('os');
const process = require('process');

let arch = os.arch();
if (process.platform === 'win32' && process.env['PROCESSOR_ARCHITEW6432'] != null) {
  arch = 'x64';
}

module.exports = {
  release: os.release(),
  arch
};