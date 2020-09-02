'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _fs = require('fs');

var _fs2 = _interopRequireDefault(_fs);

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

// TODO: sync fs operations could cause slowdown and/or freezes, depending on usage
//       if this is fine, remove this todo
class Settings {
  constructor(root) {
    this.path = _path2.default.join(root, 'settings.json');
    try {
      this.lastSaved = _fs2.default.readFileSync(this.path);
      this.settings = JSON.parse(this.lastSaved);
    } catch (e) {
      this.lastSaved = '';
      this.settings = {};
    }
    this.lastModified = this._lastModified();
  }

  _lastModified() {
    try {
      return _fs2.default.statSync(this.path).mtime.getTime();
    } catch (e) {
      return 0;
    }
  }

  get(key, defaultValue = false) {
    if (this.settings.hasOwnProperty(key)) {
      return this.settings[key];
    }

    return defaultValue;
  }

  set(key, value) {
    this.settings[key] = value;
  }

  save() {
    if (this.lastModified && this.lastModified !== this._lastModified()) {
      console.warn('Not saving settings, it has been externally modified.');
      return;
    }

    try {
      const toSave = JSON.stringify(this.settings, null, 2);
      if (this.lastSaved != toSave) {
        this.lastSaved = toSave;
        _fs2.default.writeFileSync(this.path, toSave);
        this.lastModified = this._lastModified();
      }
    } catch (err) {
      console.warn('Failed saving settings with error: ', err);
    }
  }
}
exports.default = Settings;
module.exports = exports.default;