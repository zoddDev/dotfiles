'use strict';

const electron = require('electron');
const invariant = require('invariant');

const { CLIPBOARD_COPY, CLIPBOARD_CUT, CLIPBOARD_PASTE } = require('../common/constants').IPCEvents;

function copy(text) {
  if (text) {
    electron.clipboard.writeText(text);
  } else {
    electron.ipcRenderer.invoke(CLIPBOARD_COPY);
  }
}

function copyImage(imageArrayBuffer, imageSrc) {
  invariant(imageArrayBuffer != null, 'Image data is empty');

  const nativeImg = electron.nativeImage.createFromBuffer(imageArrayBuffer);
  electron.clipboard.write({ html: `<img src="${imageSrc}">`, image: nativeImg });
}

function cut() {
  electron.ipcRenderer.invoke(CLIPBOARD_CUT);
}

function paste() {
  electron.ipcRenderer.invoke(CLIPBOARD_PASTE);
}

function read() {
  return electron.clipboard.readText();
}

module.exports = {
  copy,
  copyImage,
  cut,
  paste,
  read
};