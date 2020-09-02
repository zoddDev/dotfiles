'use strict';

let flushDNSCache = (() => {
  var _ref = _asyncToGenerator(function* () {
    electron.ipcRenderer.invoke(PROCESS_UTILS_FLUSH_DNS_CACHE);
  });

  return function flushDNSCache() {
    return _ref.apply(this, arguments);
  };
})();

let flushCookies = (() => {
  var _ref2 = _asyncToGenerator(function* (callback) {
    try {
      yield electron.ipcRenderer.invoke(PROCESS_UTILS_FLUSH_COOKIES);
      callback();
    } catch (err) {
      callback(err);
    }
  });

  return function flushCookies(_x) {
    return _ref2.apply(this, arguments);
  };
})();

let flushStorageData = (() => {
  var _ref3 = _asyncToGenerator(function* (callback) {
    try {
      yield electron.ipcRenderer.invoke(PROCESS_UTILS_FLUSH_STORAGE_DATA);
      callback();
    } catch (err) {
      callback(err);
    }
  });

  return function flushStorageData(_x2) {
    return _ref3.apply(this, arguments);
  };
})();

let purgeMemory = (() => {
  var _ref4 = _asyncToGenerator(function* () {
    electron.webFrame.clearCache();
  });

  return function purgeMemory() {
    return _ref4.apply(this, arguments);
  };
})();

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');
const process = require('process');

const {
  PROCESS_UTILS_GET_CPU_USAGE,
  PROCESS_UTILS_GET_MEMORY_INFO,
  PROCESS_UTILS_FLUSH_DNS_CACHE,
  PROCESS_UTILS_FLUSH_COOKIES,
  PROCESS_UTILS_FLUSH_STORAGE_DATA,
  PROCESS_UTILS_GET_MAIN_ARGV_SYNC
} = require('../common/constants').IPCEvents;
const CPU_USAGE_GATHER_INTERVAL = 1000;
const MEMORY_USAGE_GATHER_INTERVAL = 5000;

const mainArgv = electron.ipcRenderer.sendSync(PROCESS_UTILS_GET_MAIN_ARGV_SYNC);
let totalProcessorUsagePercent = 0;
let totalMemoryUsageKB = 0;

setInterval(() => {
  electron.ipcRenderer.invoke(PROCESS_UTILS_GET_CPU_USAGE).then(usage => totalProcessorUsagePercent = usage);
}, CPU_USAGE_GATHER_INTERVAL);

setInterval(() => {
  Promise.all([process.getProcessMemoryInfo(), electron.ipcRenderer.invoke(PROCESS_UTILS_GET_MEMORY_INFO)].map(x => x.catch(() => 0))).then(usages => {
    totalMemoryUsageKB = usages.reduce((total, usage) => total + usage.private, 0);
  });
}, MEMORY_USAGE_GATHER_INTERVAL);

function getCurrentCPUUsagePercent() {
  return totalProcessorUsagePercent;
}

function getCurrentMemoryUsageKB() {
  return totalMemoryUsageKB;
}

function getMainArgvSync() {
  return mainArgv;
}

module.exports = {
  flushDNSCache,
  flushCookies,
  flushStorageData,
  purgeMemory,
  getCurrentCPUUsagePercent,
  getCurrentMemoryUsageKB,
  getMainArgvSync
};