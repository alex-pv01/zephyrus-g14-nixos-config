{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    fuzzel
    grim
    slurp
    imv
    blueman
    hyprlock
    brightnessctl
    playerctl
  ];
}
