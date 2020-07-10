# SpellChecker Node Module [![Build Status](https://travis-ci.org/atom/node-spellchecker.svg?branch=master)](https://travis-ci.org/atom/node-spellchecker) [![Build status](https://ci.appveyor.com/api/projects/status/up294b734wagwlaw/branch/master?svg=true)](https://ci.appveyor.com/project/kevinsawicki/node-spellchecker/branch/master)

Native bindings to [NSSpellChecker](https://developer.apple.com/library/mac/#documentation/cocoa/reference/ApplicationKit/Classes/NSSpellChecker_Class/Reference/Reference.html), [Hunspell](http://hunspell.sourceforge.net/), or the [Windows 8 Spell Check API](https://msdn.microsoft.com/en-us/library/windows/desktop/hh869853(v=vs.85).aspx), depending on your platform. Windows 7 and below as well as Linux will rely on Hunspell.

## Installing

```bash
npm install spellchecker
```

## Using

```coffeescript
SpellChecker = require 'spellchecker'
```

### SpellChecker.isMisspelled(word)

Check if a word is misspelled.

`word` - String word to check.

Returns `true` if the word is misspelled, `false` otherwise.

### SpellChecker.getCorrectionsForMisspelling(word)

Get the corrections for a misspelled word.

`word` - String word to get corrections for.

Returns a non-null but possibly empty array of string corrections.

### SpellChecker.checkSpelling(corpus)

Identify misspelled words in a corpus of text.

`corpus` - String corpus of text to spellcheck.

Returns an Array containing `{start, end}` objects that describe an index range within the original String that contains a misspelled word.

### SpellChecker.checkSpellingAsync(corpus)

Asynchronously identify misspelled words.

`corpus` - String corpus of text to spellcheck.

Returns a Promise that resolves with the Array described by `checkSpelling()`.

### SpellChecker.add(word)

Adds a word to the dictionary.
When using Hunspell, this will not modify the .dic file; new words must be added each time the spellchecker is created. Use a custom dictionary file.

`word` - String word to add.

Returns nothing.

### new Spellchecker()

In addition to the above functions that are used on a default instance, a new instance of SpellChecker can be instantiated with the use of the `new` operator. The same methods are available with the instance but the dictionary and underlying API can be changed independently from the default instance.

```javascript
const checker = new SpellChecker.Spellchecker()
```

#### SpellChecker.Spellchecker.setSpellcheckerType(type)

Overrides the library selection for checking. Without this, the checker will use [Hunspell](http://hunspell.github.io/) on Linux, the [Spell Checking API](https://docs.microsoft.com/en-us/windows/desktop/intl/spell-checker-api) for Windows, and [NSSpellChecker](https://developer.apple.com/documentation/appkit/nsspellchecker) on Macs.

If the environment variable `SPELLCHECKER_PREFER_HUNSPELL` is set to any value, the library will fallback to always using the Hunspell implementation.

This is the same behavior as calling `setSpellcheckerType` with the `USE_SYSTEM_DEFAULTS` constant:

```coffeescript
checker = new SpellChecker.Spellchecker
checker.setSpellcheckerType SpellChecker.USE_SYSTEM_DEFAULTS
```

To always use the system API and not fallback to Hunspell regardless of the environment variable, use the `ALWAYS_USE_SYSTEM` constant:

```coffeescript
checker = new SpellChecker.Spellchecker
checker.setSpellcheckerType SpellChecker.ALWAYS_USE_SYSTEM
```

Likewise, Hunspell can be forced with the `ALWAYS_USE_HUNSPELL` constant.

```javascript
const checker = new SpellChecker.Spellchecker();
checker.setSpellcheckerType(SpellChecker.ALWAYS_USE_SYSTEM);
```

On Linux, Hunspell is always used regardless of the setting. This method must also be called before any spelling is done otherwise it will throw an error.

This returns nothing.
