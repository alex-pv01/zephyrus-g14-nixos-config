{ config, pkgs, ... }:

{
  networking.firewall.checkReversePath = "loose";
}
