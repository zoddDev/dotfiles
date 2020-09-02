'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.init = init;
exports.getRequestCA = getRequestCA;

var _fs = require('fs');

var _fs2 = _interopRequireDefault(_fs);

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

let requestCA;

function init() {
  let rootCertificateAuthorities;
  try {
    rootCertificateAuthorities = _fs2.default.readFileSync(_path2.default.join(__dirname, 'data', 'cacert.pem'));
  } catch (err) {
    console.error('Unable to load root certificate authorities.');
    console.error(err);
  }

  requestCA = rootCertificateAuthorities ? { ca: rootCertificateAuthorities } : {};
}

// TODO: do we use this export?
function getRequestCA() {
  return requestCA;
}