'use strict';

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

electron.ipcMain.handle(PROCESS_UTILS_GET_CPU_USAGE, (() => {
  var _ref = _asyncToGenerator(function* (_) {
    let totalProcessorUsagePercent = 0.0;
    for (const processMetric of electron.app.getAppMetrics()) {
      totalProcessorUsagePercent += processMetric.cpu.percentCPUUsage;
    }
    return totalProcessorUsagePercent;
  });

  return function (_x) {
    return _ref.apply(this, arguments);
  };
})());

electron.ipcMain.handle(PROCESS_UTILS_GET_MEMORY_INFO, (() => {
  var _ref2 = _asyncToGenerator(function* (_) {
    return process.getProcessMemoryInfo();
  });

  return function (_x2) {
    return _ref2.apply(this, arguments);
  };
})());

electron.ipcMain.handle(PROCESS_UTILS_FLUSH_DNS_CACHE, (() => {
  var _ref3 = _asyncToGenerator(function* (_) {
    const defaultSession = electron.session.defaultSession;
    if (!defaultSession || !defaultSession.clearHostResolverCache) return;
    defaultSession.clearHostResolverCache();
  });

  return function (_x3) {
    return _ref3.apply(this, arguments);
  };
})());

electron.ipcMain.handle(PROCESS_UTILS_FLUSH_COOKIES, (() => {
  var _ref4 = _asyncToGenerator(function* (_) {
    return electron.session.defaultSession.cookies.flushStore();
  });

  return function (_x4) {
    return _ref4.apply(this, arguments);
  };
})());

electron.ipcMain.handle(PROCESS_UTILS_FLUSH_STORAGE_DATA, (() => {
  var _ref5 = _asyncToGenerator(function* (_) {
    electron.session.defaultSession.flushStorageData();
  });

  return function (_x5) {
    return _ref5.apply(this, arguments);
  };
})());

electron.ipcMain.on(PROCESS_UTILS_GET_MAIN_ARGV_SYNC, event => {
  event.returnValue = process.argv;
});