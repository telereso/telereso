#!/bin/bash

rm -rf _config.yml

./gradlew prepareReadMe prepareConfigFile

cp _config.yml website/_config.yml
cp README.md website/temp-index.md

rm -rf website/doc
cp -R doc website/doc

cd website || exit

rm -rf index.md

{
  cat index-data.yml
  printf "\n"
  cat temp-index.md
} >>index.md

rm -rf temp-index.md

bundle exec jekyll clean

if [[ "$1" == "prod" ]]; then
  bundle exec jekyll build
  bucket=gs://telereso.io
  gsutil -m cp -r _site/* "${bucket}"

else
  bundle exec jekyll serve
fi


