#!/bin/bash

if [ "$CI" != "" ]; then
  git config --global --add safe.directory /app
  git config --global --add safe.directory /github/workspace
fi

version_file="src/motoko_cli/__about__.py"
tmp_version_file="src/motoko_cli/__about__-tmp.py"
base_version="0.0.1rc0.dev0"
git_hash=$(git rev-parse --short HEAD)

if [ "$CI" != "" ]; then
  python -c "open('$tmp_version_file', 'w', encoding='utf-8').write(open('$version_file', 'r', encoding='utf-8').read().replace('$base_version', '0.0.1rc0.dev0+$git_hash')); import shutil; shutil.move('$tmp_version_file', '$version_file')"
fi

rm -rf ./dist
hatch build

pip install .
pytest ./tests --junitxml=python-report.xml
