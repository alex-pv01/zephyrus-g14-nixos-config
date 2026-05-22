# NixOS Config — ASUS Zephyrus G14

NixOS flake configuration for the ASUS Zephyrus G14 with Home Manager, Hyprland, and Caelestia shell.

## Hardware

- **Laptop**: ASUS ROG Zephyrus G14 (2021, GA401QC)
- **GPU**: AMD iGPU + NVIDIA RTX 3050 (hybrid offload mode)
- **OS**: NixOS 25.11

## Components

| Component | Implementation |
|---|---|
| **Window Manager** | [Hyprland](https://hyprland.org/) (dev flake) + [Caelestia Shell](https://github.com/caelestia-dots/shell) |
| **Terminal** | Alacritty |
| **Shell** | Bash + Starship |
| **Launcher** | Fuzzel |
| **Display Manager** | SDDM (Astronaut theme, pixel_sakura) |
| **Color Scheme** | [Rose Pine](https://rosepinetheme.com/) (dark: Moon, light: Dawn) via Caelestia |
| **GTK/Qt Theme** | Catppuccin Mocha Pink |
| **Icons** | Papirus (Catppuccin folders) |
| **Cursors** | Catppuccin Mocha Pink / Bibata |
| **Fonts** | JetBrains Mono (Nerd Font), Noto Sans/Serif, Noto Color Emoji |
| **Browser** | Firefox |
| **Audio** | PipeWire + JACK |

## Repository Structure

```
.
├── flake.nix                           # Flake entry point
├── hosts/
│   └── zephyrus-g14/
│       ├── default.nix                 # System config (boot, locale, networking, users)
│       └── hardware-configuration.nix  # Auto-generated hardware config
├── modules/                            # NixOS system modules
│   ├── zephyrus-g14.nix               # AMD/NVIDIA hybrid GPU, asusctl, supergfxctl
│   ├── hyprland.nix                   # Hyprland compositor
│   ├── theme.nix                      # GTK/Qt/cursor theming
│   ├── fonts.nix                      # System fonts
│   ├── music.nix                      # JACK, PAM realtime limits for audio production
│   ├── gaming.nix                     # Steam, 32-bit graphics
│   └── proton.nix                     # ProtonVPN (loose reverse path for WireGuard)
└── home/                               # Home Manager modules
    ├── default.nix                    # Home entry point, XDG mime defaults, HiDPI (172 dpi)
    ├── shell/                         # Bash + Starship prompt
    ├── programs/
    │   ├── dev-tools.nix              # CLI tools, tmux, btop, uv, kaggle
    │   ├── alacritty.nix              # Terminal (256color, clipboard selection)
    │   ├── git.nix                    # Git config
    │   ├── creative.nix               # Blender, Krita, Inkscape, GIMP, OBS, mpv, imv
    │   ├── music.nix                  # Ardour, Reaper, LMMS, Audacity, MuseScore, Carla
    │   ├── office.nix                 # Obsidian, LibreOffice, spell-check (EN/ES/DA)
    │   ├── gaming.nix                 # Discord, Wine, MangoHud
    │   ├── media.nix                  # Spotify
    │   ├── ai.nix                     # Claude Code
    │   ├── proton.nix                 # ProtonVPN GUI
    │   └── wayland.nix                # Wayland utils (grim, slurp, wl-clipboard, fuzzel)
    └── hyprland/
        ├── default.nix                # Keybinds, appearance, animations, dwindle layout
        └── caelestia.nix              # Caelestia shell + Rose Pine dark/light toggle

```

## Notable Details

- **NVIDIA hybrid offload**: AMD iGPU drives the display, NVIDIA RTX 3050 available on demand via `nvidia-offload`. Fine-grained power management keeps the dGPU off when idle.
- **asusctl + supergfxctl**: Fan profiles and GPU mode switching for the Zephyrus G14.
- **btop with CUDA**: Built with `cudaSupport = true` to monitor RTX 3050 usage. Uses Caelestia color theme and shows GPU box by default.
- **tmux from git master**: Overridden to build from upstream HEAD for `focus-follows-mouse` support (not yet in any release).
- **Hyprland dev flake**: Uses the development version, not the nixpkgs package.
- **Caelestia shell**: Desktop shell with bar, drawers, sidebar, and notifications. Includes a `toggle-mode` script (`Super+Shift+D`) to switch between Rose Pine Moon (dark) and Dawn (light).
- **Audio production ready**: JACK enabled via PipeWire, PAM limits set for realtime scheduling (unlimited memlock, rtprio 99).
- **HiDPI**: Xft.dpi set to 172, cursor size 16.
- **nix-ld enabled**: For dynamically linked binaries from tools like `uv` (Python package manager).
- **ProtonVPN**: Firewall reverse path set to `loose` for WireGuard compatibility.
- **Screenshots**: `Print` for region select (via grim + slurp), `Shift+Print` for full screen — both copy to clipboard.
- **Alacritty as default terminal**: Set via `xdg-terminals.list` so Nautilus and other apps open it.
- **Spell-check**: Hunspell dictionaries for English, Spanish, and Danish.

## Usage

> **Warning**: This config contains hardware-specific settings for the ASUS Zephyrus G14. Adapt the files below for your machine.

### Fresh Install

1. Install NixOS with flakes enabled.
2. Clone this repo:
   ```bash
   git clone https://github.com/YOUR_USER/nixos-config ~/nixos-config
   ```
3. Replace `hardware-configuration.nix` with the one generated for your machine:
   ```bash
   cp /etc/nixos/hardware-configuration.nix ~/nixos-config/hosts/zephyrus-g14/
   ```
4. Update GPU PCI bus IDs in `modules/zephyrus-g14.nix` if they differ:
   ```bash
   lspci | grep -E "VGA|3D"
   ```
5. Build and switch:
   ```bash
   sudo nixos-rebuild switch --flake ~/nixos-config
   ```

### Updating

```bash
cd ~/nixos-config
nix flake update
sudo nixos-rebuild switch --flake .
```

## Keybindings

| Key | Action |
|---|---|
| `Super + Return` | Open terminal |
| `Super + D` | App launcher (Fuzzel) |
| `Super + Q` | Kill active window |
| `Super + B` | Open Firefox |
| `Super + E` | Yazi (terminal file manager) |
| `Super + Shift + E` | Nautilus (graphical file manager) |
| `Super + Shift + T` | Tmux session |
| `Super + Shift + D` | Toggle dark/light mode |
| `Super + N` | Toggle sidebar |
| `Super + F` | Fullscreen |
| `Super + V` | Toggle floating |
| `Super + S` | Scratchpad |
| `Super + L` | Lock session |
| `Super + 1-0` | Switch workspace |
| `Super + Shift + 1-0` | Move window to workspace |
| `Print` | Screenshot region to clipboard |
| `Shift + Print` | Screenshot full screen to clipboard |

## Acknowledgements

- [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config) — Inspiration
- [NixOS & Nix Flakes Book](https://github.com/ryan4yin/nixos-and-flakes-book) — Learning resource
- [Caelestia](https://github.com/caelestia-dots/shell) — Desktop shell
- [Hyprland](https://hyprland.org/) — Wayland compositor
