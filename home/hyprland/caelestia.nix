{ config, pkgs, ... }:

{
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
    };
    cli = {
      enable = true;
    };
  };
}
