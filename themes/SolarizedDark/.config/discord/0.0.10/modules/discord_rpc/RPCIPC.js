"use strict";

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

// Provides native APIs for RPCIPC transport.
//
// Because we're passing through some native APIs, e.g. net, we recast its API
// to something more browser-safe, so don't assume the APIs are 1:1 or behave
// exactly like the native APIs.
var process = require('process');

var path = require('path');

var fs = require('fs');

var net = require('net');

var EventEmitter = require('events');

var IS_WINDOWS = process.platform === 'win32';
var SOCKET_PATH;

if (IS_WINDOWS) {
  SOCKET_PATH = '\\\\?\\pipe\\discord-ipc';
} else {
  var temp = process.env.XDG_RUNTIME_DIR || process.env.TMPDIR || process.env.TMP || process.env.TEMP || '/tmp';
  SOCKET_PATH = path.join(temp, 'discord-ipc');
} // converts Node.js Buffer to ArrayBuffer


function toArrayBuffer(buffer) {
  return buffer.buffer.slice(buffer.byteOffset, buffer.byteOffset + buffer.byteLength);
}

function getAvailableSocket(testSocketPathFn) {
  var tries = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 0;
  var lastErr = arguments.length > 2 ? arguments[2] : undefined;

  if (tries > 9) {
    return Promise.reject(new Error("Max tries exceeded, last error: ".concat(lastErr)));
  }

  var socketPath = "".concat(SOCKET_PATH, "-").concat(tries);
  var socket = net.createConnection(socketPath);
  return testSocketPathFn(socket).then(function () {
    if (!IS_WINDOWS) {
      try {
        fs.unlinkSync(socketPath);
      } catch (err) {}
    }

    return socketPath;
  }, function (err) {
    return getAvailableSocket(testSocketPathFn, tries + 1, err);
  });
}

function recastNetSocket(socket) {
  var Socket =
  /*#__PURE__*/
  function (_EventEmitter) {
    _inherits(Socket, _EventEmitter);

    function Socket() {
      var _this;

      _classCallCheck(this, Socket);

      _this = _possibleConstructorReturn(this, _getPrototypeOf(Socket).call(this));
      _this._didHandshake = false;
      socket.on('error', function (err) {
        return _this.emit('error', err);
      });
      socket.on('close', function () {
        return _this.emit('close');
      });
      socket.on('readable', function () {
        return _this.emit('readable');
      });
      return _this;
    }

    _createClass(Socket, [{
      key: "pause",
      value: function pause() {
        socket.pause();
      }
    }, {
      key: "destroy",
      value: function destroy() {
        socket.destroy();
      } // for data sending, we recast Buffer to ArrayBuffer on the way out
      // and ArrayBuffer to Buffer on the way in

    }, {
      key: "write",
      value: function write(buffer) {
        socket.write(Buffer.from(buffer));
      }
    }, {
      key: "end",
      value: function end(buffer) {
        socket.end(Buffer.from(buffer));
      }
    }, {
      key: "read",
      value: function read(len) {
        var buf = socket.read(len);
        if (!buf) return buf;
        return toArrayBuffer(buf);
      }
    }]);

    return Socket;
  }(EventEmitter);

  return new Socket();
}

function recastNetServer(server) {
  var Server =
  /*#__PURE__*/
  function (_EventEmitter2) {
    _inherits(Server, _EventEmitter2);

    function Server() {
      var _this2;

      _classCallCheck(this, Server);

      _this2 = _possibleConstructorReturn(this, _getPrototypeOf(Server).call(this));
      server.on('error', function (err) {
        return _this2.emit('error', err);
      });
      return _this2;
    }

    _createClass(Server, [{
      key: "address",
      value: function address() {
        return server.address();
      }
    }, {
      key: "listen",
      value: function listen(socketPath, onListening) {
        server.listen(socketPath, function () {
          onListening();
        });
      }
    }, {
      key: "listening",
      get: function get() {
        return !!server.listening;
      }
    }]);

    return Server;
  }(EventEmitter);

  return new Server();
}

var proxiedNet = {
  createServer: function createServer(onConnection) {
    var server = net.createServer(function (socket) {
      onConnection(recastNetSocket(socket));
    });
    return recastNetServer(server);
  }
};
module.exports = {
  getAvailableSocket: getAvailableSocket,
  net: proxiedNet
};
