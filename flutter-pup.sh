#!/bin/bash

echo "Removing old files..."
rm -rf flutter_telereso/pubspec.yaml
rm -rf flutter_telereso/README.md
rm -rf flutter_telereso/CHANGELOG.md

rm -rf telereso_generator/pubspec.yaml
rm -rf telereso_generator/README.md
rm -rf telereso_generator/CHANGELOG.md

echo "Creating form templates..."
./gradlew prepareFlutterPubSpec prepareFlutterReadMe prepareFlutterChangeLog prepareFlutterGeneratroPubSpec prepareFlutterGeneratroReadMe prepareFlutterGeneratroChangeLog

echo "publishing..."

cd flutter_telereso || exit 1

dart pub publish

cd ..

cd telereso_generator || exit 1

dart pub publish


