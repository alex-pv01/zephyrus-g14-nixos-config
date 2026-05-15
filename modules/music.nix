{ config, pkgs, ... }:

{
  # Enable JACK support in pipewire for pro audio
  services.pipewire.jack.enable = true;

  # Enable realtime scheduling for audio work
  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio";  type = "-"; value = "99"; }
    { domain = "@audio"; item = "nofile";  type = "soft"; value = "99999"; }
    { domain = "@audio"; item = "nofile";  type = "hard"; value = "99999"; }
  ];

  users.users.alex.extraGroups = [ "audio" ];
}
