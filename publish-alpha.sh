#!/bin/bash

circleci config pack src > orb.yml
circleci orb validate orb.yml
circleci orb publish orb.yml accurics/accurics-cli@dev:alpha
rm -rf orb.yml
