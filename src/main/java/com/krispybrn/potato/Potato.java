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
