'use strict';

const electron = require('electron');

function getDesktopCaptureSources(options) {
  return new Promise((resolve, reject) => {
    electron.desktopCapturer.getSources(options).then(sources => {
      return resolve(sources.map(source => {
        return {
          id: source.id,
          name: source.name,
          url: source.thumbnail.toDataURL()
        };
      }));
    });
  });
}

module.exports = {
  getDesktopCaptureSources
};