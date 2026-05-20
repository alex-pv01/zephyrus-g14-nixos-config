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

  xdg.configFile."xdg-terminals.list".text = "alacritty\n";

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = "imv-dir.desktop";
      "image/jpeg" = "imv-dir.desktop";
      "image/gif" = "imv-dir.desktop";
      "image/webp" = "imv-dir.desktop";
      "image/bmp" = "imv-dir.desktop";
      "image/tiff" = "imv-dir.desktop";
      "image/svg+xml" = "imv-dir.desktop";
    };
  };

  home.stateVersion = "25.11";
}
