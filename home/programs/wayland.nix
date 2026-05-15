{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    fuzzel
    grim
    slurp
    brightnessctl
    playerctl
  ];
}
