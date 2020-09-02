'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.startup = startup;
exports.handleSingleInstance = handleSingleInstance;
exports.setMainWindowVisible = setMainWindowVisible;
const { Menu, BrowserWindow } = require('electron');

let mainScreen;
function startup(bootstrapModules) {
  // below modules are required and initted
  // in this order to prevent dependency conflicts
  // please don't tamper with the order unless you know what you're doing
  require('./bootstrapModules').init(bootstrapModules);

  require('./paths');
  require('./splashScreen');
  const moduleUpdater = require('./moduleUpdater');
  require('./autoStart');
  const buildInfo = require('./buildInfo');
  const appSettings = require('./appSettings');

  const Constants = require('./Constants');
  Constants.init(bootstrapModules.Constants);

  const appFeatures = require('./appFeatures');
  appFeatures.init();

  const GPUSettings = require('./GPUSettings');
  bootstrapModules.GPUSettings.replace(GPUSettings);

  const rootCertificates = require('./rootCertificates');
  rootCertificates.init();

  require('./discord_native/browser/accessibility');
  const app = require('./discord_native/browser/app');
  app.injectBuildInfo(buildInfo);
  app.injectModuleUpdater(moduleUpdater);
  require('./discord_native/browser/clipboard');
  const crashReporter = require('./discord_native/browser/crashReporter');
  crashReporter.injectBuildInfo(buildInfo);
  const features = require('./discord_native/browser/features');
  features.injectFeaturesBackend(appFeatures.getFeatures());
  require('./discord_native/browser/fileManager');
  const gpuSettings = require('./discord_native/browser/gpuSettings');
  gpuSettings.injectGpuSettingsBackend(GPUSettings);
  const nativeModules = require('./discord_native/browser/nativeModules');
  nativeModules.injectModuleUpdater(moduleUpdater);
  require('./discord_native/browser/powerMonitor');
  require('./discord_native/browser/powerSaveBlocker');
  require('./discord_native/browser/processUtils');
  const settings = require('./discord_native/browser/settings');
  settings.injectSettingsBackend(appSettings.getSettings());
  require('./discord_native/browser/spellCheck');
  const windowNative = require('./discord_native/browser/window');

  // expose globals that will be imported by the webapp
  // global.releaseChannel is set in bootstrap
  global.crashReporterMetadata = crashReporter.metadata;
  global.mainAppDirname = Constants.MAIN_APP_DIRNAME;
  global.features = appFeatures.getFeatures();
  global.appSettings = appSettings.getSettings();
  // this gets updated when launching a new main app window
  global.mainWindowId = Constants.DEFAULT_MAIN_WINDOW_ID;
  global.moduleUpdater = moduleUpdater;

  const applicationMenu = require('./applicationMenu');
  Menu.setApplicationMenu(applicationMenu);

  mainScreen = require('./mainScreen');
  mainScreen.init();

  const { getWindow: getPopoutWindowByKey } = require('./popoutWindows');
  windowNative.injectGetWindow(key => {
    return getPopoutWindowByKey(key) || BrowserWindow.fromId(mainScreen.getMainWindowId());
  });
}

function handleSingleInstance(args) {
  mainScreen.handleSingleInstance(args);
}

function setMainWindowVisible(visible) {
  mainScreen.setMainWindowVisible(visible);
}