{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "Alex";
      email = "alex-pv01@proton.me";
    };
  };
}
