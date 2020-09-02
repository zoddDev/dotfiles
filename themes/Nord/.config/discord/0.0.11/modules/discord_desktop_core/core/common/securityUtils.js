'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.saferShellOpenExternal = saferShellOpenExternal;

var _electron = require('electron');

var _url = require('url');

var _url2 = _interopRequireDefault(_url);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const BLOCKED_URL_PROTOCOLS = ['file:', 'javascript:', 'vbscript:', 'data:', 'about:', 'chrome:'];

function saferShellOpenExternal(externalUrl) {
  let parsedUrl;
  try {
    parsedUrl = _url2.default.parse(externalUrl);
  } catch (_) {
    return;
  }

  if (parsedUrl.protocol == null || BLOCKED_URL_PROTOCOLS.includes(parsedUrl.protocol.toLowerCase())) {
    return;
  }

  _electron.shell.openExternal(externalUrl);
}