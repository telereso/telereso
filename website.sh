#!/bin/bash

rm -rf _config.yml

./gradlew prepareReadMe prepareConfigFile

cp README.md temp-index.md

{
  cat index-data.yml
  printf "\n"
  cat temp-index.md
} >>index.md

rm -rf temp-index.md

bundle exec jekyll clean

if [[ "$1" == "prod" ]]; then
  bundle exec jekyll build
else
  bundle exec jekyll serve
fi

echo "cleaning files..."
rm -rf _config.yml
rm -rf index.md



