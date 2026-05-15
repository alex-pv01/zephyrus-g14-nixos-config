{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    blender
    krita
    inkscape
    gimp
    obs-studio

    mpv
    imv
  ];
}
