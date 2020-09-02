'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.cleanOldVersions = cleanOldVersions;
exports.init = init;
exports.getUserData = getUserData;
exports.getUserDataVersioned = getUserDataVersioned;
exports.getResources = getResources;
exports.getModulePath = getModulePath;

var _fs = require('fs');

var _fs2 = _interopRequireDefault(_fs);

var _mkdirp = require('mkdirp');

var _mkdirp2 = _interopRequireDefault(_mkdirp);

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var _rimraf = require('rimraf');

var _rimraf2 = _interopRequireDefault(_rimraf);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

// Determines environment-specific paths based on info provided
const originalFs = require('original-fs');

let userDataPath = null;
let userDataVersionedPath = null;
let resourcesPath = null;
let modulePath = null;

function determineAppUserDataRoot() {
  const { app } = require('electron');
  return app.getPath('appData');
}

function determineUserData(userDataRoot, buildInfo) {
  return _path2.default.join(userDataRoot, 'discord' + (buildInfo.releaseChannel == 'stable' ? '' : buildInfo.releaseChannel));
}

// cleans old version data in the background
function cleanOldVersions(buildInfo) {
  const entries = _fs2.default.readdirSync(userDataPath) || [];
  entries.forEach(entry => {
    const fullPath = _path2.default.join(userDataPath, entry);
    if (_fs2.default.lstatSync(fullPath).isDirectory() && entry.indexOf(buildInfo.version) === -1) {
      if (entry.match('^[0-9]+.[0-9]+.[0-9]+') != null) {
        console.log('Removing old directory ', entry);
        (0, _rimraf2.default)(fullPath, originalFs, error => {
          if (error) {
            console.warn('...failed with error: ', error);
          }
        });
      }
    }
  });
}

function init(buildInfo) {
  resourcesPath = _path2.default.join(require.main.filename, '..', '..', '..');

  const userDataRoot = determineAppUserDataRoot();

  userDataPath = determineUserData(userDataRoot, buildInfo);

  const { app } = require('electron');
  app.setPath('userData', userDataPath);

  userDataVersionedPath = _path2.default.join(userDataPath, buildInfo.version);
  _mkdirp2.default.sync(userDataVersionedPath);

  modulePath = buildInfo.localModulesRoot ? buildInfo.localModulesRoot : _path2.default.join(userDataVersionedPath, 'modules');
}

function getUserData() {
  return userDataPath;
}

function getUserDataVersioned() {
  return userDataVersionedPath;
}

function getResources() {
  return resourcesPath;
}

function getModulePath() {
  return modulePath;
}