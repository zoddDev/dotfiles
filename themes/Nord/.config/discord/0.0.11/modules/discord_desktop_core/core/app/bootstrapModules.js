"use strict";

let hasInit = false;

exports.init = function (bootstrapModules) {
  if (hasInit) {
    throw new Error(`bootstrapModules has already init`);
  }
  for (const mod of Object.keys(bootstrapModules)) {
    exports[mod] = bootstrapModules[mod];
  }
  hasInit = true;
};