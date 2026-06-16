{ config, pkgs, inputs, lib, ... }:

{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # GTK portal for libadwaita settings (dark/light mode in Nautilus, etc.)
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
