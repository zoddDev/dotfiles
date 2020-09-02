'use strict';

const electron = require('electron');

const { FEATURES_GET_BROWSER_FEATURES } = require('../common/constants').IPCEvents;

let supportedFeatures = new Set(electron.ipcRenderer.sendSync(FEATURES_GET_BROWSER_FEATURES));

function supports(feature) {
  return supportedFeatures.has(feature);
}

function declareSupported(feature) {
  supportedFeatures.add(feature);
}

module.exports = {
  supports,
  declareSupported
};