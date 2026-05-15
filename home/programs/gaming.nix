{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord-ptb
    winetricks
    mangohud
  ];
}
