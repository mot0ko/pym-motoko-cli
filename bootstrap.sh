#!/bin/bash

# pip install ./src/python/
# pytest src/python/tests --junitxml=python-report.xml

rm -rf ./dist
hatch build
