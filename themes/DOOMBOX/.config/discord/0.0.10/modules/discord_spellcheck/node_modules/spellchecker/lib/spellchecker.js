var path = require('path');
var Promise = require('any-promise');
var bindings = require('../build/Release/spellchecker.node');

var Spellchecker = bindings.Spellchecker;

var checkSpellingAsyncCb = Spellchecker.prototype.checkSpellingAsync

Spellchecker.prototype.checkSpellingAsync = function (corpus) {
  return new Promise(function (resolve, reject) {
    checkSpellingAsyncCb.call(this, corpus, function (err, result) {
      if (err) {
        reject(err);
      } else {
        resolve(result);
      }
    });
  }.bind(this));
};

var defaultSpellcheck = null;

var ensureDefaultSpellCheck = function() {
  if (defaultSpellcheck) {
    return;
  }

  var lang = process.env.LANG;
  lang = lang ? lang.split('.')[0] : 'en_US';
  defaultSpellcheck = new Spellchecker();

  setDictionary(lang, getDictionaryPath());
};

var setDictionary = function(lang, dictPath) {
  ensureDefaultSpellCheck();
  return defaultSpellcheck.setDictionary(lang, dictPath);
};

var isMisspelled = function() {
  ensureDefaultSpellCheck();

  return defaultSpellcheck.isMisspelled.apply(defaultSpellcheck, arguments);
};

var checkSpelling = function() {
  ensureDefaultSpellCheck();

  return defaultSpellcheck.checkSpelling.apply(defaultSpellcheck, arguments);
};

var checkSpellingAsync = function(corpus) {
  ensureDefaultSpellCheck();

  return defaultSpellcheck.checkSpellingAsync.apply(defaultSpellcheck, arguments);
};

var add = function() {
  ensureDefaultSpellCheck();

  defaultSpellcheck.add.apply(defaultSpellcheck, arguments);
};

var remove = function() {
  ensureDefaultSpellCheck();

  defaultSpellcheck.remove.apply(defaultSpellcheck, arguments);
};

var getCorrectionsForMisspelling = function() {
  ensureDefaultSpellCheck();

  return defaultSpellcheck.getCorrectionsForMisspelling.apply(defaultSpellcheck, arguments);
};

var getAvailableDictionaries = function() {
  ensureDefaultSpellCheck();

  return defaultSpellcheck.getAvailableDictionaries.apply(defaultSpellcheck, arguments);
};

var getDictionaryPath = function() {
  var dict = path.join(__dirname, '..', 'vendor', 'hunspell_dictionaries');
  try {
    // HACK: Special case being in an asar archive
    var unpacked = dict.replace('.asar' + path.sep, '.asar.unpacked' + path.sep);
    if (require('fs').statSync(unpacked)) {
      dict = unpacked;
    }
  } catch (error) {
    // When the dictionary isn't contained within an .asar, return the original path.
  }
  return dict;
}

module.exports = {
  setDictionary: setDictionary,
  add: add,
  remove: remove,
  isMisspelled: isMisspelled,
  checkSpelling: checkSpelling,
  checkSpellingAsync: checkSpellingAsync,
  getAvailableDictionaries: getAvailableDictionaries,
  getCorrectionsForMisspelling: getCorrectionsForMisspelling,
  getDictionaryPath: getDictionaryPath,
  Spellchecker: Spellchecker,
  USE_SYSTEM_DEFAULTS: 0,
  ALWAYS_USE_SYSTEM: 1,
  ALWAYS_USE_HUNSPELL: 2,
};
