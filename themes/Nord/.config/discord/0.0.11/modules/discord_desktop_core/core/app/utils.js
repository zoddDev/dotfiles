'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.exposeModuleResource = exposeModuleResource;

var _fs = require('fs');

var _fs2 = _interopRequireDefault(_fs);

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var _paths = require('./paths');

var paths = _interopRequireWildcard(_paths);

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function exposeModuleResource(asarPath, fileName) {
  const appPath = _path2.default.resolve(__dirname, '..');
  const fullPathToAsarFile = _path2.default.join(appPath, asarPath, fileName);
  const data = _fs2.default.readFileSync(fullPathToAsarFile);
  const nativeFilePath = _path2.default.join(paths.getUserData(), fileName);
  _fs2.default.writeFileSync(nativeFilePath, data);
  return nativeFilePath;
} // Miscellaneous utility functions.