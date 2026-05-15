{ config, pkgs, lib, ... }:

{
  # Hyprland compositor
  programs.hyprland.enable = true;

  # Greetd display manager with tuigreet
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions /run/current-system/sw/share/wayland-sessions:/run/current-system/sw/share/xsessions";
        user = "greeter";
      };
    };
  };

  # XWayland support
  #programs.xwayland.enable = true;

  # Wayland environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    #MOZ_ENABLE_WAYLAND = "1";
    #MOZ_WEBRENDER = "1";
    #ELECTRON_OZONE_PLATFORM_HINT = "auto";
    #_JAVA_AWT_WM_NONREPARENTING = "1";
    #QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    #SDL_VIDEODRIVER = "wayland";
    #GDK_BACKEND = "wayland,x11";
    #XDG_SESSION_TYPE = "wayland";
  };

  # Wayland ecosystem tools
  environment.systemPackages = with pkgs; [
    # Bar / launcher / notifications / lock
    waybar
    fuzzel
    mako
    swaylock
    swaybg

    # Clipboard
    wl-clipboard

    # Screenshots
    grim
    slurp
    satty

    # Brightness & media
    brightnessctl
    playerctl
    pavucontrol

    # Terminal (lightweight Wayland-native fallback)
    foot

    # XWayland bridge
    xwayland-satellite

    # Polkit agent
    kdePackages.polkit-kde-agent-1
  ];

  # Allow swaylock to authenticate
  #security.pam.services.swaylock = {};
}
