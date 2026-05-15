{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "custom/performance" "bluetooth" "pulseaudio" "network" "battery" "tray" ];

        "hyprland/workspaces" = {
          format = "{id}";
          on-click = "activate";
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%A %d %B %Y}";
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󱐋 {capacity}%";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };

        network = {
          format-wifi = "󰤨 {signalStrength}%";
          format-ethernet = "󰈀";
          format-disconnected = "󰤭";
          tooltip-format = "{ifname}: {ipaddr}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        bluetooth = {
          format = "󰂯";
          format-connected = "󰂱 {num_connections}";
          format-disabled = "󰂲";
          tooltip-format = "{controller_alias}\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}";
          on-click = "blueman-manager";
        };

        "custom/performance" = {
          format = "{}";
          interval = 5;
          exec = ''asusctl profile -p 2>/dev/null | awk '{print $NF}' | sed 's/Quiet/󰌪/;s/Balanced/󰈐/;s/Performance/󰓅/'''';
          on-click = "asusctl profile -n";
          tooltip-format = "Click to cycle performance profile";
        };

        tray = {
          spacing = 10;
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
      }

      window#waybar {
        background-color: rgba(30, 30, 46, 0.9);
        color: #cdd6f4;
        border-bottom: 2px solid rgba(245, 194, 231, 0.5);
      }

      #workspaces button {
        padding: 0 8px;
        color: #6c7086;
        border-radius: 5px;
        margin: 3px 2px;
      }

      #workspaces button.active {
        color: #f5c2e7;
        background-color: rgba(245, 194, 231, 0.2);
      }

      #workspaces button:hover {
        background-color: rgba(245, 194, 231, 0.1);
      }

      #custom-performance {
        padding: 0 10px;
      }

      #bluetooth {
        padding: 0 10px;
      }

      #bluetooth.connected {
        color: #89b4fa;
      }

      #bluetooth.disabled {
        color: #6c7086;
      }

      #clock,
      #battery,
      #network,
      #pulseaudio,
      #tray {
        padding: 0 10px;
      }

      #battery.warning {
        color: #f9e2af;
      }

      #battery.critical {
        color: #f38ba8;
      }
    '';
  };
}
