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
