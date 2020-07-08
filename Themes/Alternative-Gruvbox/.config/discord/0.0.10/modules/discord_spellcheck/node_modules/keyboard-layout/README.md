# keyboard-layout
[![macOS Build Status](https://travis-ci.org/atom/keyboard-layout.svg?branch=master)](https://travis-ci.org/atom/keyboard-layout)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/rk8wooeyh689apgd/branch/master?svg=true)](https://ci.appveyor.com/project/Atom/keyboard-layout)
[![Dependency Status](https://david-dm.org/atom/keyboard-layout/status.svg)](https://david-dm.org/atom/keyboard-layout)

Read and observe the current keyboard layout.

To get the current keyboard layout, call `getCurrentKeyboardLayout`. It returns
the string identifier of the current layout based on the value returned by the
operating system.

```js
const KeyboardLayout = require('keyboard-layout')
KeyboardLayout.getCurrentKeyboardLayout() // => "com.apple.keylayout.Dvorak"
```

If you want to watch for layout changes, use `onDidChangeCurrentKeyboardLayout`
or `observeCurrentKeyboardLayout`. They work the same, except
`observeCurrentKeyboardLayout` invokes the given callback immediately with the
current layout value and then again next time it changes, whereas
`onDidChangeCurrentKeyboardLayout` only invokes the callback on the next
change.

```js
const KeyboardLayout = require('keyboard-layout')
subscription = KeyboardLayout.observeCurrentKeyboardLayout((layout) => console.log(layout))
subscription.dispose() // to unsubscribe later
```

To return characters for various modifier states based on a DOM 3
`KeyboardEvent.code` value and the current system keyboard layout, use
`getCurrentKeymap()`:

```js
const KeyboardLayout = require('keyboard-layout')
KeyboardLayout.getCurrentKeymap()['KeyS']
/*
On a US layout, this returns:
{
  unmodified: 's',
  withShift: 'S',
  withAltGraph: 'ß',
  withShiftAltGraph: 'Í'
}
*/
```
