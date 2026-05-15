{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Alex";
    userEmail = "alex-pv01@proton.me";
  };
}
