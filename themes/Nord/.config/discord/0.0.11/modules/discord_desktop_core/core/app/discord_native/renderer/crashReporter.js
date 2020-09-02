'use strict';

let updateCrashReporter = (() => {
  var _ref = _asyncToGenerator(function* (additional_metadata) {
    const result = yield electron.ipcRenderer.invoke(CRASH_REPORTER_UPDATE_METADATA, additional_metadata);
    // Calling crashReporter.start from a renderer process was deprecated in Electron 9.
    if (getElectronMajorVersion() < 9) {
      electron.crashReporter.start(result.args);
    }
    metadata = result.metadata || {};

    reconcileCrashReporterMetadata(electron.crashReporter, metadata);
  });

  return function updateCrashReporter(_x) {
    return _ref.apply(this, arguments);
  };
})();

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');
const { getElectronMajorVersion, reconcileCrashReporterMetadata } = require('../common/utility');

const { CRASH_REPORTER_UPDATE_METADATA } = require('../common/constants').IPCEvents;

let metadata = {};

updateCrashReporter(metadata);

function getMetadata() {
  return metadata;
}

module.exports = {
  updateCrashReporter,
  getMetadata
};