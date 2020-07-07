"use strict";

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _get(target, property, receiver) { if (typeof Reflect !== "undefined" && Reflect.get) { _get = Reflect.get; } else { _get = function _get(target, property, receiver) { var base = _superPropBase(target, property); if (!base) return; var desc = Object.getOwnPropertyDescriptor(base, property); if (desc.get) { return desc.get.call(receiver); } return desc.value; }; } return _get(target, property, receiver || target); }

function _superPropBase(object, property) { while (!Object.prototype.hasOwnProperty.call(object, property)) { object = _getPrototypeOf(object); if (object === null) break; } return object; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

// Provides native APIs for RPCWebSocket transport.
//
// Because we're passing through some native APIs, e.g. net, we recast its API
// to something more browser-safe, so don't assume the APIs are 1:1 or behave
// exactly like the native APIs.
var EventEmitter = require('events');

var http = require('http');

var ws = require('ws');

var origInstanceMap = new WeakMap(); // converts Node.js Buffer to ArrayBuffer

function toArrayBuffer(buffer) {
  return buffer.buffer.slice(buffer.byteOffset, buffer.byteOffset + buffer.byteLength);
}

function recastWSSocket(socket, req) {
  var WSSocket =
  /*#__PURE__*/
  function (_EventEmitter) {
    _inherits(WSSocket, _EventEmitter);

    function WSSocket() {
      var _this;

      _classCallCheck(this, WSSocket);

      _this = _possibleConstructorReturn(this, _getPrototypeOf(WSSocket).call(this));
      _this.upgradeReq = {
        url: req.url,
        headers: {
          origin: req.headers.origin
        }
      };
      socket.on('error', function (err) {
        return _this.emit('error', err);
      });
      socket.on('close', function (code, message) {
        return _this.emit('close', code, message);
      });
      socket.on('message', function (data) {
        if (data instanceof Buffer) {
          data = toArrayBuffer(data);
        }

        _this.emit('message', data);
      });
      return _this;
    }

    _createClass(WSSocket, [{
      key: "send",
      value: function send(data) {
        var opts = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

        if (opts.binary) {
          data = Buffer.from(data);
        }

        try {
          socket.send(data, opts);
        } catch (e) {
          // ws shouldn't be throwing when CLOSED or CLOSING
          // currently being addressed in https://github.com/websockets/ws/pull/1532
          if (!e.message.match(/CLOS(ED|ING)/)) {
            throw e;
          }
        }
      }
    }, {
      key: "close",
      value: function close(code, message) {
        socket.close(code, message);
      }
    }]);

    return WSSocket;
  }(EventEmitter);

  return new WSSocket();
}

function getWrappedWSServer() {
  var wss;
  return (
    /*#__PURE__*/
    function (_EventEmitter2) {
      _inherits(ProxiedWSServer, _EventEmitter2);

      function ProxiedWSServer(opts) {
        var _this2;

        _classCallCheck(this, ProxiedWSServer);

        _this2 = _possibleConstructorReturn(this, _getPrototypeOf(ProxiedWSServer).call(this)); // opts.server that comes in is our remapped server, so we
        // get the original

        if (opts.server) {
          opts.server = origInstanceMap.get(opts.server);
        }

        wss = new ws.Server(opts);
        wss.on('connection', function (socket, req) {
          return _this2.emit('connection', recastWSSocket(socket, req));
        });
        return _this2;
      }

      return ProxiedWSServer;
    }(EventEmitter)
  );
}

var proxiedWS = {
  get Server() {
    return getWrappedWSServer();
  }

};

function recastHTTPReq(req) {
  var ProxiedHTTPRequest =
  /*#__PURE__*/
  function (_EventEmitter3) {
    _inherits(ProxiedHTTPRequest, _EventEmitter3);

    function ProxiedHTTPRequest() {
      var _getPrototypeOf2;

      var _this3;

      _classCallCheck(this, ProxiedHTTPRequest);

      for (var _len = arguments.length, args = new Array(_len), _key = 0; _key < _len; _key++) {
        args[_key] = arguments[_key];
      }

      _this3 = _possibleConstructorReturn(this, (_getPrototypeOf2 = _getPrototypeOf(ProxiedHTTPRequest)).call.apply(_getPrototypeOf2, [this].concat(args)));
      _this3.attached = false;
      return _this3;
    }

    _createClass(ProxiedHTTPRequest, [{
      key: "on",
      value: function on(evt) {
        var _this4 = this,
            _get2;

        // We need to attach listeners for data only on data event, which sets the
        // request to flowing mode.
        if (evt === 'data' && !this.attached) {
          req.on('error', function (err) {
            return _this4.emit('error', err);
          });
          req.on('end', function () {
            return _this4.emit('end');
          });
          req.on('data', function (data) {
            // force cast the data to a string
            // this is because we only deal with string data on http requests so far
            _this4.emit('data', '' + data);
          });
          this.attached = true;
        }

        for (var _len2 = arguments.length, args = new Array(_len2 > 1 ? _len2 - 1 : 0), _key2 = 1; _key2 < _len2; _key2++) {
          args[_key2 - 1] = arguments[_key2];
        }

        (_get2 = _get(_getPrototypeOf(ProxiedHTTPRequest.prototype), "on", this)).call.apply(_get2, [this, evt].concat(args));
      }
    }, {
      key: "url",
      get: function get() {
        return req.url;
      }
    }, {
      key: "method",
      get: function get() {
        return req.method;
      }
    }, {
      key: "headers",
      get: function get() {
        return req.headers;
      }
    }]);

    return ProxiedHTTPRequest;
  }(EventEmitter);

  var recast = new ProxiedHTTPRequest();
  origInstanceMap.set(recast, req);
  return recast;
}

function recastHTTPRes(res) {
  var ProxiedHTTPResponse =
  /*#__PURE__*/
  function () {
    function ProxiedHTTPResponse() {
      _classCallCheck(this, ProxiedHTTPResponse);
    }

    _createClass(ProxiedHTTPResponse, [{
      key: "setHeader",
      value: function setHeader(header, value) {
        res.setHeader(header, value);
      }
    }, {
      key: "writeHead",
      value: function writeHead(status, headers) {
        res.writeHead(status, headers);
      }
    }, {
      key: "end",
      value: function end(body) {
        res.end(body);
      }
    }]);

    return ProxiedHTTPResponse;
  }();

  var recast = new ProxiedHTTPResponse();
  origInstanceMap.set(recast, res);
  return recast;
}

function createWrappedHTTPServer() {
  var server = http.createServer();

  var ProxiedHTTPServer =
  /*#__PURE__*/
  function (_EventEmitter4) {
    _inherits(ProxiedHTTPServer, _EventEmitter4);

    function ProxiedHTTPServer() {
      var _this5;

      _classCallCheck(this, ProxiedHTTPServer);

      _this5 = _possibleConstructorReturn(this, _getPrototypeOf(ProxiedHTTPServer).call(this));
      server.on('error', function (err) {
        return _this5.emit('error', err);
      });
      server.on('request', function (_req, _res) {
        var req = recastHTTPReq(_req);
        var res = recastHTTPRes(_res);

        _this5.emit('request', req, res);
      });
      return _this5;
    }

    _createClass(ProxiedHTTPServer, [{
      key: "address",
      value: function address() {
        return server.address();
      }
    }, {
      key: "listen",
      value: function listen(port, host, callback) {
        server.listen(port, host, callback);
      }
    }, {
      key: "listening",
      get: function get() {
        return server.listening;
      }
    }]);

    return ProxiedHTTPServer;
  }(EventEmitter);

  var recast = new ProxiedHTTPServer();
  origInstanceMap.set(recast, server);
  return recast;
}

var proxiedHTTP = {
  createServer: createWrappedHTTPServer
};
module.exports = {
  ws: proxiedWS,
  http: proxiedHTTP
};
