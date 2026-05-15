{ config, pkgs, ... }:

{
  imports = [
    ./shell
    ./programs
  ];

  home.username = "alex";
  home.homeDirectory = "/home/alex";

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.stateVersion = "25.11";
}
