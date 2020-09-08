
require("electron").session.defaultSession.webRequest.onHeadersReceived(({ responseHeaders }, done) => {
  Object.keys(responseHeaders)
  .filter(k => (/^content-security-policy/i).test(k) || (/^x-frame-options/i).test(k))
  .map(k => (delete responseHeaders[k]));

  done({ responseHeaders });
});


require("electron").session.defaultSession.webRequest.onHeadersReceived(({ responseHeaders }, done) => {
  Object.keys(responseHeaders)
  .filter(k => (/^content-security-policy/i).test(k) || (/^x-frame-options/i).test(k))
  .map(k => (delete responseHeaders[k]));

  done({ responseHeaders });
});


require("electron").session.defaultSession.webRequest.onHeadersReceived(({ responseHeaders }, done) => {
  Object.keys(responseHeaders)
  .filter(k => (/^content-security-policy/i).test(k) || (/^x-frame-options/i).test(k))
  .map(k => (delete responseHeaders[k]));

  done({ responseHeaders });
});


require("electron").session.defaultSession.webRequest.onHeadersReceived(({ responseHeaders }, done) => {
  Object.keys(responseHeaders)
  .filter(k => (/^content-security-policy/i).test(k) || (/^x-frame-options/i).test(k))
  .map(k => (delete responseHeaders[k]));

  done({ responseHeaders });
});

module.exports = require('./core.asar');