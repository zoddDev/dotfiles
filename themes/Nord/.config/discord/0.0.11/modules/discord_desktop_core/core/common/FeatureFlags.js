'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
class FeatureFlags {
  constructor() {
    this.flags = new Set();
  }

  getSupported() {
    return Array.from(this.flags);
  }

  supports(feature) {
    return this.flags.has(feature);
  }

  declareSupported(feature) {
    if (this.supports(feature)) {
      console.error('Feature redeclared; is this a duplicate flag? ', feature);
      return;
    }

    this.flags.add(feature);
  }
}
exports.default = FeatureFlags;
module.exports = exports.default;