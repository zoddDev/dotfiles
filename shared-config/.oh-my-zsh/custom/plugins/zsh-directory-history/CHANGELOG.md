# Change Log

## 1.1.0 (2016-04-07)

**Implemented enhancements:**

- Faster processing of large history files
- Commands in the history file are no longer separated by newlines. Instead the plugin uses `\0` to separate commands
- History file formats from previous versions are no longer supported

**Closed issues:**

- Plugin crash when command contains newline [\#12](https://github.com/tymm/zsh-directory-history/issues/12)
- Commands containing `;` do not show up entirely [\#13](https://github.com/tymm/zsh-directory-history/issues/13)
