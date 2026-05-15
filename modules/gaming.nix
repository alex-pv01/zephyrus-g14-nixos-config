{ config, pkgs, ... }:

{
  # Steam
  programs.steam = {
    enable = true;
  };

  # For 32-bit graphics support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
