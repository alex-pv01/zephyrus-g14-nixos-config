{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ardour       # Full-featured DAW
    reaper       # Professional DAW
    lmms         # Beat/melody production
    audacity     # Audio editor
    carla        # Audio plugin host (VST/LV2/LADSPA)
    hydrogen     # Drum machine
    musescore    # Music notation
  ];
}
