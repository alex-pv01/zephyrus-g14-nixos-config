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

  # Portal config: use GTK backend for Settings (dark/light mode for apps)
  xdg.configFile."xdg-desktop-portal/hyprland-portals.conf".text = ''
    [preferred]
    default=hyprland;gtk
    org.freedesktop.impl.portal.Settings=gtk
  '';

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
