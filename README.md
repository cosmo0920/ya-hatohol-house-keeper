Yet Another Hatohol House Keeper
===

[![Build Status](https://travis-ci.org/cosmo0920/ya-hatohol-house-keeper.svg?branch=master)](https://travis-ci.org/cosmo0920/ya-hatohol-house-keeper)

## Prepare

* Stack

## Try it

```bash
$ git submodule update --init
$ stack setup
$ stack build
```

## Dependent packages

* HDBC related cabal packages (including sqlite3, postgresql, and mysql) and HRR!

## Usage

1. Setup Hatohol packages before compiling
2. prepare haskell-stack environment
3. stack build (also you can run test code with `stack test`)
4. execute with `--table`, `--stat`, and `--date` options. (`--date` option is optional)

## Limitations

* `--number` option does not support. So, you can't specify how amount of deleting record directly. Use `--date` option instead.

## LICENSE

* [BSD3](LICENSE)
