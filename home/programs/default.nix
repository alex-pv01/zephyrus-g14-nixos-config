{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./alacritty.nix
    ./dev-tools.nix
    ./office.nix
    ./winapps.nix
    ./creative.nix
    ./music.nix
    ./gaming.nix
    ./proton.nix
    ./ai.nix
    ./media.nix
    ./wayland.nix
  ];
}
