#!/bin/bash

echo "Removing old files..."
rm -rf react-native/package.json
rm -rf react-native/CHANGELOG.md

echo "Creating form templates..."
./gradlew prepareRNPackage prepareRNChangeLog

echo "publishing..."

cd react-native || exit 1

npm publish



