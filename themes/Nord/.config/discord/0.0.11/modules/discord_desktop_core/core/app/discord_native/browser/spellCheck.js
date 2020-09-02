'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const electron = require('electron');

const {
  SPELLCHECK_REPLACE_MISSPELLING,
  SPELLCHECK_GET_AVAILABLE_DICTIONARIES,
  SPELLCHECK_SET_LOCALE,
  SPELLCHECK_SET_LEARNED_WORDS
} = require('../common/constants').IPCEvents;

let _learnedWords = new Set();
let _hasLoadedLearnedWords = false;

electron.ipcMain.handle(SPELLCHECK_REPLACE_MISSPELLING, (() => {
  var _ref = _asyncToGenerator(function* (event, correction) {
    event.sender.replaceMisspelling(correction);
  });

  return function (_x, _x2) {
    return _ref.apply(this, arguments);
  };
})());

electron.ipcMain.handle(SPELLCHECK_GET_AVAILABLE_DICTIONARIES, (() => {
  var _ref2 = _asyncToGenerator(function* (_) {
    return electron.session.defaultSession.availableSpellCheckerLanguages;
  });

  return function (_x3) {
    return _ref2.apply(this, arguments);
  };
})());

electron.ipcMain.handle(SPELLCHECK_SET_LOCALE, (() => {
  var _ref3 = _asyncToGenerator(function* (_, locale) {
    electron.session.defaultSession.setSpellCheckerLanguages([locale]);
  });

  return function (_x4, _x5) {
    return _ref3.apply(this, arguments);
  };
})());

electron.ipcMain.handle(SPELLCHECK_SET_LEARNED_WORDS, (() => {
  var _ref4 = _asyncToGenerator(function* (_, newLearnedWords) {
    const session = electron.session.defaultSession;

    if (!_hasLoadedLearnedWords) {
      const dictionaryContents = yield session.listWordsInSpellCheckerDictionary();
      _learnedWords = new Set(dictionaryContents);
      _hasLoadedLearnedWords = true;
    }

    _learnedWords.forEach(function (word) {
      if (!newLearnedWords.has(word)) {
        session.removeWordFromSpellCheckerDictionary(word);
      }
    });

    newLearnedWords.forEach(function (word) {
      if (!_learnedWords.has(word)) {
        session.addWordToSpellCheckerDictionary(word);
      }
    });

    _learnedWords = new Set(newLearnedWords);
  });

  return function (_x6, _x7) {
    return _ref4.apply(this, arguments);
  };
})());