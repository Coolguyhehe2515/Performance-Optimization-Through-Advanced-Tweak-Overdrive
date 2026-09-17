#!/usr/bin/env bash
set -e
export JAVA_HOME=/opt/java8

FORGE=1.12.2-14.23.5.2860
URL="https://maven.minecraftforge.net/net/minecraftforge/forge/$FORGE/forge-$FORGE-mdk.zip"

if [ ! -f gradlew ]; then
    TMP=$(mktemp -d)
    wget -q -O "$TMP/mdk.zip" "$URL"
    unzip -q "$TMP/mdk.zip" -d "$TMP/mdk"
    cp "$TMP/mdk/build.gradle" .
    cp "$TMP/mdk/gradlew" .
    cp -r "$TMP/mdk/gradle" .
    chmod +x gradlew
    rm -rf "$TMP"
fi

./gradlew setupDecompWorkspace
./gradlew build
