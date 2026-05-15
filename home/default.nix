{ config, pkgs, ... }:

{
  imports = [
    ./shell
    ./programs
    ./hyprland
  ];

  home.username = "alex";
  home.homeDirectory = "/home/alex";

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications."image/*" = "imv.desktop";
  };

  home.stateVersion = "25.11";
}
