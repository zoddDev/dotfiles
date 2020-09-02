'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.init = init;
exports.getFeatures = getFeatures;

var _FeatureFlags = require('../common/FeatureFlags');

var _FeatureFlags2 = _interopRequireDefault(_FeatureFlags);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

let features;

function init() {
  features = new _FeatureFlags2.default();
}

function getFeatures() {
  return features;
}