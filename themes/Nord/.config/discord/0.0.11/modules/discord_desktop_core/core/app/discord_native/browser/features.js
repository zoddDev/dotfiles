'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.injectFeaturesBackend = injectFeaturesBackend;
const electron = require('electron');

const { FEATURES_GET_BROWSER_FEATURES } = require('../common/constants').IPCEvents;

let injectedFeatures = null;

function getFeatures() {
  return injectedFeatures != null ? injectedFeatures : {
    getSupported: () => {
      return [];
    },
    supports: () => {
      return false;
    },
    declareSupported: () => {}
  };
}

function injectFeaturesBackend(features) {
  injectedFeatures = features;
}

electron.ipcMain.on(FEATURES_GET_BROWSER_FEATURES, event => {
  event.returnValue = getFeatures().getSupported();
});