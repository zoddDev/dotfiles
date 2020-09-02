// [adill] This is not context aware and, as such, won't load in newer Electron versions
// We can and should strip `discord_spellcheck` down to CLD only once all channels are on Electron 9
function getLegacySpellchecker() {
  const Spellchecker = require('spellchecker').Spellchecker;
  const instance = new Spellchecker();
  return {
    setDictionary: instance.setDictionary.bind(instance),
    getAvailableDictionaries: instance.getAvailableDictionaries.bind(instance),
    isMisspelled: instance.isMisspelled.bind(instance),
    getCorrectionsForMisspelling: instance.getCorrectionsForMisspelling.bind(instance),
  };
}

// [adill] This is not context aware and, as such, won't load in newer Electron versions
// We can and should strip `discord_spellcheck` down to CLD only once all channels are on Electron 9
function getKeyboardLayout() {
  return require('keyboard-layout');
}

module.exports = {
  cld: require('cld'),
  getLegacySpellchecker,
  getKeyboardLayout,
};
