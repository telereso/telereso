#!/bin/bash

echo "Removing old files..."
rm -rf web/package.json
rm -rf web/CHANGELOG.md
rm -rf web/build

echo "Creating form templates..."
./gradlew prepareWebPackage prepareWebChangeLog

echo "publishing..."

cd web || exit 1

yarn build

npm publish



