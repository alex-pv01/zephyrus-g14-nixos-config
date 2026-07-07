{ config, pkgs, ... }:

{
  # Docker daemon
  virtualisation.docker.enable = true;

  # Allow alex to use docker without sudo
  users.users.alex.extraGroups = [ "docker" ];
}
