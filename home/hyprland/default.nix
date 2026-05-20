{ config, pkgs, inputs, ... }:

{
  imports = [
    ./caelestia.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    settings = {
      # Monitor config — HDMI-A-1 above laptop, others auto-detected to the right
      monitor = [
        "HDMI-A-1,preferred,auto-up,1"
        ",preferred,auto,1"
      ];

      # Mod key
      "$mod" = "SUPER";
      "$terminal" = "alacritty";
      "$menu" = "fuzzel";

      # Autostart
      exec-once = [
        "caelestia-shell"
        "$terminal"
      ];

      # General
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(f5c2e7ff) rgba(cba6f7ff) 45deg";
        "col.inactive_border" = "rgba(585b70ff)";
        layout = "dwindle";
      };

      # Decoration
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      # Animations
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };


      # Input
      input = {
        kb_layout = "es";
        kb_variant = "cat";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
        };
      };


      # Keybindings
      bind = [
        "$mod, Return, exec, $terminal"
        "$mod, Q, killactive,"
        "$mod SHIFT, Q, exit,"
        "$mod, E, exec, alacritty -e yazi"
        "$mod SHIFT, E, exec, nautilus"
        "$mod, V, togglefloating,"
        "$mod, D, exec, $menu"

        "$mod SHIFT, T, exec, alacritty -e tmux"
        "$mod, N, exec, caelestia shell drawers toggle sidebar"
        "$mod SHIFT, N, exec, caelestia shell notifs clear"
        "$mod, B, exec, firefox"
        "$mod, L, exec, loginctl lock-session"
        "$mod, F, fullscreen,"
        "$mod SHIFT, F, fullscreenstate, 0 2"
        "$mod, Tab, cyclenext,"

        # Move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Move window
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        # Resize window
        "$mod CTRL, left, resizeactive, -20 0"
        "$mod CTRL, right, resizeactive, 20 0"
        "$mod CTRL, up, resizeactive, 0 -20"
        "$mod CTRL, down, resizeactive, 0 20"

        # Scratchpad
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Scroll through workspaces
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Screenshots
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "SHIFT, Print, exec, grim - | wl-copy"
      ];

      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Brightness & volume keys
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };
}
