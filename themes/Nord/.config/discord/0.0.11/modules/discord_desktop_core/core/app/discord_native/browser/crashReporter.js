'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.injectBuildInfo = injectBuildInfo;

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');
const lodash = require('lodash');
const childProcess = require('child_process');
const { getElectronMajorVersion, flatten, reconcileCrashReporterMetadata } = require('../common/utility');

const { CRASH_REPORTER_UPDATE_METADATA } = require('../common/constants').IPCEvents;

const metadata = exports.metadata = {};

function injectBuildInfo(buildInfo) {
  metadata['channel'] = buildInfo.releaseChannel;
  const sentryMetadata = metadata['sentry'] != null ? metadata['sentry'] : {};
  sentryMetadata['environment'] = buildInfo.releaseChannel;
  sentryMetadata['release'] = buildInfo.version;
  metadata['sentry'] = sentryMetadata;
}

if (process.platform === 'linux') {
  const XDG_CURRENT_DESKTOP = process.env.XDG_CURRENT_DESKTOP || 'unknown';
  const GDMSESSION = process.env.GDMSESSION || 'unknown';
  metadata['wm'] = `${XDG_CURRENT_DESKTOP},${GDMSESSION}`;
  try {
    metadata['distro'] = childProcess.execFileSync('lsb_release', ['-ds'], { timeout: 100, maxBuffer: 512, encoding: 'utf-8' }).trim();
  } catch (_) {} // just in case lsb_release doesn't exist
}

function getCrashReporterArgs(metadata) {
  // NB: we need to flatten the metadata because modern electron caps metadata values at 127 bytes,
  // which our sentry subobject can easily exceed.
  let flat_metadata = flatten(metadata);

  return {
    productName: 'Discord',
    companyName: 'Discord Inc.',
    submitURL: 'https://sentry.io/api/146342/minidump/?sentry_key=384ce4413de74fe0be270abe03b2b35a',
    uploadToServer: true,
    ignoreSystemCrashHandler: false,
    extra: flat_metadata
  };
}

electron.crashReporter.start(getCrashReporterArgs(metadata));

electron.ipcMain.handle(CRASH_REPORTER_UPDATE_METADATA, (() => {
  var _ref = _asyncToGenerator(function* (_, additional_metadata) {
    const final_metadata = lodash.defaultsDeep({}, metadata, additional_metadata || {});
    const result = {
      metadata: final_metadata
    };

    // In Electron 9 we only start the crashReporter once and let reconcileCrashReporterMetadata
    // do the work of keeping `extra` up-to-date. Prior to this we would simply start crashReporter
    // again to apply new metadata as well as pass the full arguments back to the renderer so it
    // could do similarly.
    if (getElectronMajorVersion() < 9) {
      const args = getCrashReporterArgs(final_metadata);
      electron.crashReporter.start(args);
      result.args = args;
    }

    reconcileCrashReporterMetadata(electron.crashReporter, final_metadata);
    return result;
  });

  return function (_x, _x2) {
    return _ref.apply(this, arguments);
  };
})());