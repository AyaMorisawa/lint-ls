[![Build Status](https://travis-ci.org/AyaMorisawa/lint-ls.svg?branch=master)](https://travis-ci.org/AyaMorisawa/lint-ls)
[![npm version](https://img.shields.io/npm/v/lint-ls.svg)](https://www.npmjs.com/package/lint-ls)
[![Downloads](http://img.shields.io/npm/dm/lint-ls.svg)](https://npmjs.org/package/lint-ls)
[![License](https://img.shields.io/npm/l/lint-ls.svg)](LICENSE)

# lint-ls
Linter for LiveScript

## Install
`npm install lint-ls`

## Usage
### Basic
```ls
require! \lint-ls

result = lint-ls source, option
```

```ls
require! \lint-ls

result = lint-ls source # Default option will be used
```

### File
```ls
require! <[ lint-ls fs ]>
read-file = (filename) -> fs.read-file-sync filename .to-string!

result = read-file 'hoge.ls' |> lint-ls _, option
```

### Gulp
Use [gulp-lint-ls](https://github.com/AyaMorisawa/gulp-lint-ls)

## License
MIT
