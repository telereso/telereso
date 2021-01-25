#!/bin/bash

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

bundle exec jekyll serve
