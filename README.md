# sloane.sh

## Setup

```sh
brew install --cask racket
raco pkg install pollen
```

## Working on the site

```sh
raco pollen start site
```

## Building the site

```sh
mkdir -p build
raco pollen render site
raco pollen publish site build
```
