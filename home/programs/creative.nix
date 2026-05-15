{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    blender
    krita
    inkscape
    gimp
    obs-studio
    mpv
    imv
  ];
}
