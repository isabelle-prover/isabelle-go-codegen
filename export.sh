#!/usr/bin/env bash

version="$(git describe --tags)"
file="go-codegen-$version.zip"

echo "Exporting to $file ..."

git archive \
  --format=zip \
  --prefix=Go_Codegen/ \
  --output="$file" \
  HEAD
