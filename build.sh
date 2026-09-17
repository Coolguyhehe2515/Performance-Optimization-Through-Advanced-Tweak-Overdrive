#!/data/data/com.termux/files/usr/bin/bash
set -e

cd "$(dirname "$0")"

JDK="$HOME/.potato-jdk8"
FORGE="1.12.2-14.23.5.2860"
JDK_URL="https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u504-b01/OpenJDK8U-jdk_aarch64_linux_hotspot_8u504b01.tar.gz"
FORGE_URL="https://maven.minecraftforge.net/net/minecraftforge/forge/$FORGE/forge-$FORGE-mdk.zip"

echo "=== P.O.T.A.T.O BUILD ==="

if [ ! -x "$JDK/bin/java" ]; then
    echo "[1/3] Download Java 8..."
    mkdir -p "$JDK"
    wget -q --show-progress "$JDK_URL" -O /tmp/jdk8.tar.gz
    tar -xzf /tmp/jdk8.tar.gz -C "$JDK" --strip-components=1
    rm /tmp/jdk8.tar.gz
fi

export JAVA_HOME="$JDK"
export PATH="$JAVA_HOME/bin:$PATH"

echo "[Java]"
java -version

if [ ! -f gradlew ]; then
    echo "[2/3] Download Forge MDK..."
    mkdir -p /tmp/potato-mdk
    wget -q --show-progress "$FORGE_URL" -O /tmp/forge.zip
    unzip -q /tmp/forge.zip -d /tmp/potato-mdk
    cp /tmp/potato-mdk/build.gradle .
    cp /tmp/potato-mdk/gradlew .
    cp -r /tmp/potato-mdk/gradle .
    chmod +x gradlew
    rm -rf /tmp/potato-mdk /tmp/forge.zip
fi

echo "[3/3] Build..."
./gradlew setupDecompWorkspace
./gradlew build

echo
echo "=== BUILD SELESAI ==="
ls -lh build/libs/
