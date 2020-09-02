'use strict';

let saveWithDialog = (() => {
  var _ref = _asyncToGenerator(function* (fileContents, fileName, filePath) {
    if (INVALID_FILENAME_CHAR_REGEX.test(fileName)) {
      throw new Error(`fileName has invalid characters`);
    }
    const defaultPath = filePath != null ? path.join(os.homedir(), filePath, fileName) : path.join(os.homedir(), fileName);

    const writeFileToDisk = function (selectedFileName) {
      selectedFileName && fs.writeFileSync(selectedFileName, fileContents);
    };

    const results = yield electron.ipcRenderer.invoke(FILE_MANAGER_SHOW_SAVE_DIALOG, { defaultPath });
    if (results && results.filePath) {
      fs.writeFileSync(results.filePath, fileContents);
    }
  });

  return function saveWithDialog(_x, _x2, _x3) {
    return _ref.apply(this, arguments);
  };
})();

let showOpenDialog = (() => {
  var _ref2 = _asyncToGenerator(function* (dialogOptions) {
    const results = yield electron.ipcRenderer.invoke(FILE_MANAGER_SHOW_OPEN_DIALOG, dialogOptions);
    return results.filePaths;
  });

  return function showOpenDialog(_x4) {
    return _ref2.apply(this, arguments);
  };
})();

let orderedFiles = (() => {
  var _ref3 = _asyncToGenerator(function* (folder) {
    try {
      const filenames = yield readdir(folder);
      const times = yield getTimes(filenames.map(function (filename) {
        return path.join(folder, filename);
      }));
      return times.filter(function (result) {
        return result.status === 'fulfilled';
      }).map(function (result) {
        return result.value;
      }).sort(function (a, b) {
        return b.mtime.getTime() - a.mtime.getTime();
      }).map(function (a) {
        return a.filename;
      });
    } catch (err) {
      return [];
    }
  });

  return function orderedFiles(_x5) {
    return _ref3.apply(this, arguments);
  };
})();

let readLogFiles = (() => {
  var _ref4 = _asyncToGenerator(function* (maxSize) {
    const modulePath = yield getModulePath();
    const webrtcLog0 = path.join(modulePath, 'discord_voice', 'discord-webrtc_0');
    const webrtcLog1 = path.join(modulePath, 'discord_voice', 'discord-webrtc_1');
    const webrtcLog2 = path.join(modulePath, 'discord_voice', 'discord-last-webrtc_0');
    const webrtcLog3 = path.join(modulePath, 'discord_voice', 'discord-last-webrtc_1');
    const hookLog = path.join(modulePath, 'discord_hook', 'hook.log');
    const audioState = path.join(modulePath, 'discord_voice', 'audio_state.json');
    const filesToUpload = [webrtcLog0, webrtcLog1, webrtcLog2, webrtcLog3, hookLog, audioState];

    const crashFolder = process.platform === 'win32' ? path.join(os.tmpdir(), 'Discord Crashes', 'reports') : path.join(os.tmpdir(), 'Discord Crashes', 'completed');
    const crashFiles = yield orderedFiles(crashFolder);
    if (crashFiles.length > 0) {
      filesToUpload.push(crashFiles[0]);
    }

    const files = yield readFiles(filesToUpload, maxSize);
    return files.filter(function (result) {
      return result.status === 'fulfilled';
    }).map(function (result) {
      return result.value;
    });
  });

  return function readLogFiles(_x6) {
    return _ref4.apply(this, arguments);
  };
})();

let showItemInFolder = (() => {
  var _ref5 = _asyncToGenerator(function* (path) {
    electron.ipcRenderer.invoke(FILE_MANAGER_SHOW_ITEM_IN_FOLDER, path);
  });

  return function showItemInFolder(_x7) {
    return _ref5.apply(this, arguments);
  };
})();

let openFiles = (() => {
  var _ref6 = _asyncToGenerator(function* (dialogOptions, maxSize) {
    const filenames = yield showOpenDialog(dialogOptions);
    if (filenames == null) {
      return;
    }
    const files = yield readFiles(filenames, maxSize);
    files.forEach(function (result) {
      if (result.status === 'rejected') {
        throw result.reason;
      }
    });
    return files.map(function (result) {
      return result.value;
    });
  });

  return function openFiles(_x8, _x9) {
    return _ref6.apply(this, arguments);
  };
})();

let getModulePath = (() => {
  var _ref7 = _asyncToGenerator(function* () {
    return electron.ipcRenderer.invoke(FILE_MANAGER_GET_MODULE_PATH);
  });

  return function getModulePath() {
    return _ref7.apply(this, arguments);
  };
})();

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');
const fs = require('fs');
const os = require('os');
const path = require('path');
const originalFs = require('original-fs');
const util = require('util');

const {
  FILE_MANAGER_GET_MODULE_PATH,
  FILE_MANAGER_SHOW_SAVE_DIALOG,
  FILE_MANAGER_SHOW_OPEN_DIALOG,
  FILE_MANAGER_SHOW_ITEM_IN_FOLDER
} = require('../common/constants').IPCEvents;

const INVALID_FILENAME_CHAR_REGEX = /[^a-zA-Z0-9-_.]/g;

const readdir = util.promisify(originalFs.readdir);

function getTimes(filenames) {
  return Promise.allSettled(filenames.map(filename => new Promise((resolve, reject) => {
    originalFs.stat(filename, (err, stats) => {
      if (err) {
        return reject(err);
      }
      if (!stats.isFile()) {
        return reject(new Error('Not a file'));
      }
      return resolve({ filename, mtime: stats.mtime });
    });
  })));
}

function readFiles(filenames, maxSize) {
  return Promise.allSettled(filenames.map(filename => new Promise((resolve, reject) => {
    originalFs.stat(filename, (err, stats) => {
      if (err) return reject(err);

      if (stats.size > maxSize) {
        const err = new Error('upload too large');
        // used to help determine why openFiles failed
        err.code = 'ETOOLARGE';
        return reject(err);
      }

      originalFs.readFile(filename, (err, data) => {
        if (err) return reject(err);
        return resolve({
          data: data.buffer,
          filename: path.basename(filename)
        });
      });
    });
  })));
}

module.exports = {
  readLogFiles,
  saveWithDialog,
  openFiles,
  showOpenDialog,
  showItemInFolder,
  getModulePath,
  extname: path.extname,
  basename: path.basename,
  dirname: path.dirname,
  join: path.join
};