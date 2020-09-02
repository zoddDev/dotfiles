'use strict';

if (!process.isMainFrame) {
  throw new Error('Preload scripts should not be running in a subframe');
}

if (window.opener === null) {
  // App preload script, used to provide a replacement native API now that
  // we turned off node integration.
  const { contextBridge } = require('electron');

  const DiscordNative = {
    isRenderer: process.type === 'renderer',

    nativeModules: require('./discord_native/renderer/nativeModules'),
    process: require('./discord_native/renderer/process'),
    os: require('./discord_native/renderer/os'),
    app: require('./discord_native/renderer/app'),
    clipboard: require('./discord_native/renderer/clipboard'),
    ipc: require('./discord_native/renderer/ipc'),
    gpuSettings: require('./discord_native/renderer/gpuSettings'),
    window: require('./discord_native/renderer/window'),
    powerMonitor: require('./discord_native/renderer/powerMonitor'),
    spellCheck: require('./discord_native/renderer/spellCheck'),
    crashReporter: require('./discord_native/renderer/crashReporter'),
    desktopCapture: require('./discord_native/renderer/desktopCapture'),
    fileManager: require('./discord_native/renderer/fileManager'),
    processUtils: require('./discord_native/renderer/processUtils'),
    powerSaveBlocker: require('./discord_native/renderer/powerSaveBlocker'),
    http: require('./discord_native/renderer/http'),
    accessibility: require('./discord_native/renderer/accessibility'),
    features: require('./discord_native/renderer/features'),
    settings: require('./discord_native/renderer/settings')
  };

  // TODO: remove these once web no longer uses them
  DiscordNative.remoteApp = DiscordNative.app;
  DiscordNative.remotePowerMonitor = DiscordNative.powerMonitor;

  contextBridge.exposeInMainWorld('DiscordNative', DiscordNative);

  const bd_fs = require('fs');
const bd_path = require('path');

contextBridge.exposeInMainWorld('BeautifulDiscord', {
    loadFile: (fileName) => {
        return bd_fs.readFileSync(fileName, 'utf-8');
    },
    readDir: (p) => {
        return bd_fs.readdirSync(p);
    },
    pathExists: (p) => {
        return bd_fs.existsSync(p);
    },
    watcher: (p, cb) => {
        return bd_fs.watch(p, { encoding: "utf-8" }, cb);
    },
    join: (a, b) => {
        return bd_path.join(a, b);
    },
    basename: (p) => {
        return bd_path.basename(p);
    },
    dirname: (p) => {
        return bd_path.dirname(p);
    },
    isDirectory: (p) => {
        return bd_fs.lstatSync(p).isDirectory()
    }
});

process.once('loaded', () => {
    global.require = require;

    // ensures native module `require` context has access to DiscordNative
    global.DiscordNative = DiscordNative;
  });

  window.popouts = new Map();
} else {
  window.addEventListener('load', _ => {
    window.opener.popouts.set(window.name, window);
  });
  window.addEventListener('beforeunload', _ => {
    window.opener.popouts.delete(window.name);
  });
}