#!/usr/bin/env bash

set -x            # print commands before execution
set -o errexit    # always exit on error
set -o pipefail   # honor exit codes when piping
set -o nounset    # fail on unset variables

git clone https://github.com/electron/repos-using-electron-part-deux module
cd module
npm install
npm run build
npm test
[[ `git status --porcelain` ]] || exit
git add .
git config user.email "zeke@sikelianos.com"
git config user.name "Zeke Sikelianos"
git commit -am "update database"
# npm version minor -m "bump minor to %s"
git push origin master --follow-tags
# npm publish