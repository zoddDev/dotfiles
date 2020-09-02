'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');
const EventEmitter = require('events');
const { getElectronMajorVersion } = require('../common/utility');

const {
  SPELLCHECK_RESULT,
  SPELLCHECK_REPLACE_MISSPELLING,
  SPELLCHECK_GET_AVAILABLE_DICTIONARIES,
  SPELLCHECK_SET_LOCALE,
  SPELLCHECK_SET_LEARNED_WORDS
} = require('../common/constants').IPCEvents;

if (getElectronMajorVersion() < 8) {
  let setSpellCheckProvider = (() => {
    var _ref = _asyncToGenerator(function* (locale, autoCorrectWord, provider) {
      const asyncProvider = {
        spellCheck: function (words, callback) {
          return callback(words.filter(function (word) {
            return !provider.spellCheck(word);
          }));
        }
      };
      electron.webFrame.setSpellCheckProvider(locale, asyncProvider);
    });

    return function setSpellCheckProvider(_x, _x2, _x3) {
      return _ref.apply(this, arguments);
    };
  })();

  let replaceMisspelling = (() => {
    var _ref2 = _asyncToGenerator(function* (word) {
      electron.ipcRenderer.invoke(SPELLCHECK_REPLACE_MISSPELLING, word);
    });

    return function replaceMisspelling(_x4) {
      return _ref2.apply(this, arguments);
    };
  })();

  module.exports = {
    setSpellCheckProvider,
    replaceMisspelling
  };
} else {
  let getAvailableDictionaries = (() => {
    var _ref3 = _asyncToGenerator(function* () {
      return electron.ipcRenderer.invoke(SPELLCHECK_GET_AVAILABLE_DICTIONARIES);
    });

    return function getAvailableDictionaries() {
      return _ref3.apply(this, arguments);
    };
  })();

  let setLocale = (() => {
    var _ref4 = _asyncToGenerator(function* (locale) {
      let succeeded = true;
      try {
        yield electron.ipcRenderer.invoke(SPELLCHECK_SET_LOCALE, locale);
      } catch (_) {
        succeeded = false;
      }

      return succeeded;
    });

    return function setLocale(_x5) {
      return _ref4.apply(this, arguments);
    };
  })();

  let setLearnedWords = (() => {
    var _ref5 = _asyncToGenerator(function* (learnedWords) {
      return electron.ipcRenderer.invoke(SPELLCHECK_SET_LEARNED_WORDS, learnedWords);
    });

    return function setLearnedWords(_x6) {
      return _ref5.apply(this, arguments);
    };
  })();

  let replaceMisspelling = (() => {
    var _ref6 = _asyncToGenerator(function* (correction) {
      return electron.ipcRenderer.invoke(SPELLCHECK_REPLACE_MISSPELLING, correction);
    });

    return function replaceMisspelling(_x7) {
      return _ref6.apply(this, arguments);
    };
  })();

  const events = new EventEmitter();

  electron.ipcRenderer.on(SPELLCHECK_RESULT, handleSpellcheckData);

  function handleSpellcheckData(_, misspelledWord, dictionarySuggestions) {
    events.emit('spellcheck-result', misspelledWord, dictionarySuggestions);
  }

  function on() {
    events.on.apply(events, arguments);
  }

  function removeListener() {
    events.removeListener.apply(events, arguments);
  }

  module.exports = {
    on,
    removeListener,
    getAvailableDictionaries,
    setLocale,
    setLearnedWords,
    replaceMisspelling
  };
}