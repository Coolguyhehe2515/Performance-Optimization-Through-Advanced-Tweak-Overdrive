#!/usr/bin/env bash
set -e
mkdir -p src/main/java/com/krispybrn/potato src/main/resources

cat > gradle.properties <<'EOF'
org.gradle.jvmargs=-Xmx2G
org.gradle.daemon=false
mod_id=potato
mod_name=P.O.T.A.T.O
mod_version=0.1.0
mod_group=com.krispybrn.potato
EOF

echo "rootProject.name = 'POTATO'" > settings.gradle

cat > .gitignore <<'EOF'
.gradle/
build/
run/
out/
logs/
.idea/
*.class
*.jar
*.zip
EOF

cat > README.md <<'EOF'
# P.O.T.A.T.O
Performance Optimization Through Advanced Tweak Overdrive

Minecraft 1.12.2 / Forge 14.23.5.2860 / Java 8
EOF

cat > build.sh <<'EOF'
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
EOF

chmod +x build.sh

cat > src/main/java/com/krispybrn/potato/Potato.java <<'EOF'
package com.krispybrn.potato;

import net.minecraftforge.common.MinecraftForge;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.event.*;

@Mod(
    modid = Potato.MOD_ID,
    name = Potato.MOD_NAME,
    version = Potato.VERSION,
    acceptedMinecraftVersions = "[1.12.2]"
)
public class Potato {
    public static final String MOD_ID = "potato";
    public static final String MOD_NAME = "P.O.T.A.T.O";
    public static final String VERSION = "0.1.0";

    @Mod.EventHandler
    public void preInit(FMLPreInitializationEvent event) {
        PotatoConfig.load(event.getSuggestedConfigurationFile());
    }

    @Mod.EventHandler
    public void init(FMLInitializationEvent event) {
        MinecraftForge.EVENT_BUS.register(new PotatoEvents());
    }
}
EOF

cat > src/main/java/com/krispybrn/potato/PotatoConfig.java <<'EOF'
package com.krispybrn.potato;

import java.io.File;
import net.minecraftforge.common.config.Configuration;

public final class PotatoConfig {
    private static Configuration config;

    public static boolean particleCulling;
    public static boolean disableParticles;
    public static boolean flipbookAnimation;
    public static boolean chunkOptimization;
    public static boolean lightingOptimization;
    public static boolean memoryOptimization;
    public static boolean aggressiveOptimization;

    public static void load(File file) {
        config = new Configuration(file);

        particleCulling = config.getBoolean("particleCulling","rendering",true,"");
        disableParticles = config.getBoolean("disableParticles","rendering",false,"");
        flipbookAnimation = config.getBoolean("flipbookAnimation","rendering",true,"");
        chunkOptimization = config.getBoolean("chunkOptimization","world",true,"");
        lightingOptimization = config.getBoolean("lightingOptimization","world",true,"");
        memoryOptimization = config.getBoolean("memoryOptimization","memory",true,"");
        aggressiveOptimization = config.getBoolean("aggressiveOptimization","advanced",false,"");

        if (config.hasChanged()) config.save();
    }

    public static Configuration getConfig() {
        return config;
    }
}
EOF

cat > src/main/java/com/krispybrn/potato/PotatoEvents.java <<'EOF'
package com.krispybrn.potato;

import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;
import net.minecraftforge.fml.common.gameevent.TickEvent;

public class PotatoEvents {
    @SubscribeEvent
    public void clientTick(TickEvent.ClientTickEvent event) {
        if (event.phase != TickEvent.Phase.END) return;
    }
}
EOF

cat > src/main/resources/mcmod.info <<'EOF'
[
  {
    "modid": "potato",
    "name": "P.O.T.A.T.O",
    "description": "Performance Optimization Through Advanced Tweak Overdrive",
    "version": "${version}",
    "mcversion": "1.12.2",
    "authorList": ["KrispyBRN"],
    "dependencies": []
  }
]
EOF

git add .
git commit -m "Initial P.O.T.A.T.O project"
git push
