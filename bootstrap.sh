#!/bin/bash

rm -rf ./dist
hatch build

pip install .
pytest ./tests --junitxml=python-report.xml
