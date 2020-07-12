const VoiceEngine = require('./discord_voice.node');
const ChildProcess = require('child_process');
const path = require('path');
const yargs = require('yargs');

const isElectronRenderer =
  typeof window !== 'undefined' && window != null && window.DiscordNative && window.DiscordNative.isRenderer;

const appSettings = isElectronRenderer ? window.DiscordNative.settings : global.appSettings;
const features = isElectronRenderer ? window.DiscordNative.features : global.features;
const mainArgv = isElectronRenderer ? window.DiscordNative.processUtils.getMainArgvSync() : [];
const releaseChannel = isElectronRenderer ? window.DiscordNative.app.getReleaseChannel() : '';
const useLegacyAudioDevice = appSettings ? appSettings.getSync('useLegacyAudioDevice') : false;
const audioSubsystemSelected = appSettings
  ? appSettings.getSync('audioSubsystem') === 'legacy'
    ? 'legacy'
    : 'standard'
  : 'standard';
const audioSubsystem = useLegacyAudioDevice || audioSubsystemSelected;
const debugLogging = appSettings ? appSettings.getSync('debugLogging') : false;

const argv = yargs(mainArgv.slice(1))
  .describe('log-level', 'Logging level.')
  .default('log-level', -1)
  .help('h')
  .alias('h', 'help')
  .exitProcess(false).argv;
const logLevel = argv['log-level'] == -1 ? (debugLogging ? 2 : -1) : argv['log-level'];

if (debugLogging && console.discordVoiceHooked == null) {
  console.discordVoiceHooked = true;

  for (const logFn of ['trace', 'debug', 'info', 'warn', 'error', 'log']) {
    const originalLogFn = console[logFn];

    if (originalLogFn != null) {
      console[logFn] = function () {
        originalLogFn.apply(this, arguments);

        try {
          VoiceEngine.consoleLog(
            logFn,
            JSON.stringify(Array.from(arguments).map((v) => (v != null ? v.toString() : v)))
          );
        } catch (e) {
          // Drop errors from toString()/stringify.
        }
      };
    }
  }
}

features.declareSupported('voice_panning');
features.declareSupported('voice_multiple_connections');
features.declareSupported('media_devices');
features.declareSupported('media_video');
features.declareSupported('debug_logging');
features.declareSupported('set_audio_device_by_id');
features.declareSupported('set_video_device_by_id');
features.declareSupported('loopback');
features.declareSupported('experiment_config');
features.declareSupported('remote_locus_network_control');
features.declareSupported('connection_replay');
features.declareSupported('simulcast');

if (process.platform === 'win32') {
  features.declareSupported('voice_legacy_subsystem');
  features.declareSupported('soundshare');
  features.declareSupported('wumpus_video');
  features.declareSupported('hybrid_video');
  features.declareSupported('elevated_hook');
  features.declareSupported('soundshare_loopback');
  features.declareSupported('screen_previews');
  features.declareSupported('window_previews');
  features.declareSupported('audio_debug_state');
  // NOTE(jvass): currently there's no experimental encoders! Add this back if you
  // add one and want to re-enable the UI for them.
  // features.declareSupported('experimental_encoders');
}

const VoiceReplayConnection = VoiceEngine.VoiceReplayConnection;

delete VoiceEngine.VoiceReplayConnection;

VoiceEngine.createTransport = VoiceEngine._createTransport;

if (isElectronRenderer) {
  VoiceEngine.setImageDataAllocator((width, height) => new window.ImageData(width, height));
}

VoiceEngine.createReplayConnection = function (audioEngineId, callback, replayLog) {
  if (replayLog == null) {
    return null;
  }

  return new VoiceReplayConnection(replayLog, audioEngineId, callback);
};

VoiceEngine.setAudioSubsystem = function (subsystem) {
  if (appSettings == null) {
    console.warn('Unable to access app settings.');
    return;
  }

  // TODO: With experiment controlling ADM selection, this may be incorrect since
  // audioSubsystem is read from settings (or default if does not exists)
  // and not the actual ADM used.
  if (subsystem === audioSubsystem) {
    return;
  }

  appSettings.set('audioSubsystem', subsystem);
  appSettings.set('useLegacyAudioDevice', false);

  if (isElectronRenderer) {
    window.DiscordNative.app.relaunch();
  }
};

VoiceEngine.setDebugLogging = function (enable) {
  if (appSettings == null) {
    console.warn('Unable to access app settings.');
    return;
  }

  if (debugLogging === enable) {
    return;
  }

  appSettings.set('debugLogging', enable);

  if (isElectronRenderer) {
    window.DiscordNative.app.relaunch();
  }
};

VoiceEngine.getDebugLogging = function () {
  return debugLogging;
};

reloadElectronApp = function () {
  if (isElectronRenderer) {
    const app = require('electron').remote.app;
    app.relaunch();
    app.exit(0);
  } else {
    ChildProcess.spawn(process.argv[0], process.argv.splice(1), {detached: true});
    process.exit(0);
  }
};

console.log(`Initializing voice engine with audio subsystem: ${audioSubsystem}`);
VoiceEngine.initialize({audioSubsystem, logLevel});

module.exports = VoiceEngine;
