#!/bin/sh

VERSION=$(head -n 1 VERSION.txt) || exit 1

rm -rfv target || exit 1

java -jar montarre.jar \
  maven-central download \
  --group com.io7m.montarre \
  --artifact com.io7m.montarre.distribution \
  --version "${VERSION}" \
  --type mpk \
  --output-file target/input/montarre.mpk || exit 1

java -jar montarre.jar \
  native create \
  --adoptium-temurin-version "21.0.5+11-LTS" \
  --package target/input/montarre.mpk \
  --output-directory target/output \
  --work-directory target/work || exit 1

