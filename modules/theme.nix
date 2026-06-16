{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Catppuccin GTK theme
    (catppuccin-gtk.override {
      accents = [ "pink" ];
      variant = "mocha";
    })

    # Catppuccin cursors
    catppuccin-cursors.mochaPink

    # Papirus icons with Rose Pine-matching folders (both dark/light)
    (catppuccin-papirus-folders.override {
      flavor = "mocha";
      accent = "mauve";
    })
    (catppuccin-papirus-folders.override {
      flavor = "latte";
      accent = "rosewater";
    })

    # Catppuccin wallpaper
    nixos-artwork.wallpapers.catppuccin-mocha

    # Bibata cursor (alternative)
    bibata-cursors
  ];

  # Set GTK theme system-wide via dconf
  programs.dconf.enable = true;

  # Qt theming to match GTK
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };
}
