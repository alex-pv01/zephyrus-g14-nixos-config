{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    fuzzel
    grim
    slurp
    hyprlock
    brightnessctl
    playerctl
  ];
}
