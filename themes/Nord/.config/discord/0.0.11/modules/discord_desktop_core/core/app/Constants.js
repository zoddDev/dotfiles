'use strict';

// before we can set up (and export) our constants, we first need to grab bootstrap's constants
// so we can merge them in with our constants
function init(bootstrapConstants) {
  const APP_NAME = bootstrapConstants.APP_NAME;
  const API_ENDPOINT = bootstrapConstants.API_ENDPOINT;
  const UPDATE_ENDPOINT = bootstrapConstants.UPDATE_ENDPOINT;
  const APP_ID = bootstrapConstants.APP_ID;

  const DEFAULT_MAIN_WINDOW_ID = 0;
  const MAIN_APP_DIRNAME = __dirname;

  const UpdaterEvents = {
    UPDATE_NOT_AVAILABLE: 'UPDATE_NOT_AVAILABLE',
    CHECKING_FOR_UPDATES: 'CHECKING_FOR_UPDATES',
    UPDATE_ERROR: 'UPDATE_ERROR',
    UPDATE_MANUALLY: 'UPDATE_MANUALLY',
    UPDATE_AVAILABLE: 'UPDATE_AVAILABLE',
    MODULE_INSTALL_PROGRESS: 'MODULE_INSTALL_PROGRESS',
    UPDATE_DOWNLOADED: 'UPDATE_DOWNLOADED',
    MODULE_INSTALLED: 'MODULE_INSTALLED',
    CHECK_FOR_UPDATES: 'CHECK_FOR_UPDATES',
    QUIT_AND_INSTALL: 'QUIT_AND_INSTALL',
    MODULE_INSTALL: 'MODULE_INSTALL',
    MODULE_QUERY: 'MODULE_QUERY',
    UPDATER_HISTORY_QUERY_AND_TRUNCATE: 'UPDATER_HISTORY_QUERY_AND_TRUNCATE',
    UPDATER_HISTORY_RESPONSE: 'UPDATER_HISTORY_RESPONSE'
  };

  const MenuEvents = {
    OPEN_HELP: 'menu:open-help',
    OPEN_SETTINGS: 'menu:open-settings',
    CHECK_FOR_UPDATES: 'menu:check-for-updates'
  };

  const exported = {
    APP_NAME,
    DEFAULT_MAIN_WINDOW_ID,
    MAIN_APP_DIRNAME,
    APP_ID,
    API_ENDPOINT,
    UPDATE_ENDPOINT,
    UpdaterEvents,
    MenuEvents
  };

  for (const key of Object.keys(exported)) {
    module.exports[key] = exported[key];
  }
}

module.exports = {
  init
};