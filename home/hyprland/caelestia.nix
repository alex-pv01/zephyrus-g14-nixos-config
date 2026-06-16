{ config, pkgs, ... }:

let
  toggle-mode = pkgs.writeShellScriptBin "toggle-mode" ''
    current_mode=$(caelestia scheme get -m)
    if [ "$current_mode" = "light" ]; then
      caelestia scheme set -n rosepine -f moon -m dark
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/icon-theme "'Papirus-Dark'"
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/gtk-theme "'adw-gtk3-dark'"
    else
      caelestia scheme set -n rosepine -f dawn -m light
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/icon-theme "'Papirus-Light'"
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/gtk-theme "'adw-gtk3'"
    fi
  '';
in
{
  home.packages = [ toggle-mode ];
  xdg.configFile."caelestia/shell.json".force = true;

  programs.caelestia = {
    enable = true;
    systemd = {
      enable = false; # start from Hyprland exec-once instead
    };
    settings = {
      general.apps = {
        terminal = [ "alacritty" ];
        audio = [ "pavucontrol" ];
        explorer = [ "yazi" ];
      };
      bar.status = {
        showBattery = true;
      };
      paths = {
        mediaGif = "~/Pictures/media.gif";
      };
    };
    cli = {
      enable = true;
    };
  };
}
