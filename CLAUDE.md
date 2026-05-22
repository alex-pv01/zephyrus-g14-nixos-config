# CLAUDE.md — Guidelines for Claude Code

This file defines the operating guide for Claude Code working in this NixOS flake repository.
Keep changes minimal, verifiable, and scoped to what was requested.

## Scope and Repository Model

This repository manages a single NixOS host (ASUS Zephyrus G14) with Home Manager integration.

```text
.
├── flake.nix              # Flake entry point
├── flake.lock
├── hosts/
│   └── zephyrus-g14/
│       ├── default.nix               # Core system config (boot, locale, networking, users)
│       └── hardware-configuration.nix # Auto-generated hardware config — do not edit manually
├── modules/               # NixOS system modules (services, hardware, system-level config)
│   ├── zephyrus-g14.nix   # GPU/ASUS hardware
│   ├── hyprland.nix       # Hyprland compositor (dev flake)
│   ├── theme.nix          # GTK/Qt theming
│   ├── fonts.nix          # System fonts
│   ├── music.nix          # Audio/JACK/PAM config
│   ├── gaming.nix         # Steam, 32-bit graphics
│   └── proton.nix         # ProtonVPN firewall
└── home/                  # Home Manager modules (user-level config and packages)
    ├── default.nix        # Home entry point — imports shell, programs, hyprland
    ├── shell/
    │   ├── default.nix    # Bash config
    │   └── starship.nix   # Starship prompt
    ├── programs/
    │   ├── default.nix    # Imports all program modules
    │   ├── git.nix
    │   ├── alacritty.nix
    │   ├── dev-tools.nix
    │   ├── office.nix
    │   ├── creative.nix
    │   ├── music.nix
    │   ├── gaming.nix
    │   ├── proton.nix
    │   ├── ai.nix
    │   └── wayland.nix
    └── hyprland/
        └── default.nix    # Hyprland Home Manager config (keybinds, appearance, etc.)
```

## Ground Rules

- Make the smallest reasonable change; avoid drive-by refactors.
- Do not commit secrets, credentials, or `.env` files.
- Do not run `nixos-rebuild` or push to remote without explicit permission.
- Do not edit `hardware-configuration.nix` — it is auto-generated.
- Do not run destructive git commands (`--force`, `reset --hard`) without asking.

## Architecture Decisions

- **Packages go in Home Manager** (`home/programs/`) unless they require system-level config (services, PAM, hardware).
- **System modules** (`modules/`) are for config that requires root or NixOS module options (`services.*`, `programs.*` that need system integration, `hardware.*`, `security.*`).
- **Hyprland** uses the development version via flake input, not nixpkgs.
- **`inputs`** is passed to both NixOS modules (via `specialArgs`) and Home Manager (via `extraSpecialArgs`).

## Validation

Before finishing, verify changes evaluate correctly:

```bash
# Format (if nixfmt is available)
nixfmt *.nix **/*.nix

# Check flake evaluates
nix flake check

# Build without deploying
nix build .#nixosConfigurations.zephyrus-g14.config.system.build.toplevel

# Deploy (only when user requests)
sudo nixos-rebuild switch --flake ~/nixos-config
```

## Nix Style Conventions

- Use 2-space indentation.
- Module arguments: `{ config, pkgs, ... }:` (add `inputs`, `lib` only when needed).
- Prefer `lib.mkIf` and `lib.mkDefault` for conditional config.
- Keep one concern per file — don't mix unrelated config in the same module.

## Common Pitfalls

- Putting user packages in `environment.systemPackages` instead of `home.packages`.
- Forgetting to add new modules to the relevant `default.nix` imports list.
- Duplicating packages across `home/programs/` files — check for overlap before adding.
- Editing `hosts/zephyrus-g14/default.nix` when the change belongs in `modules/` or `home/`.

## README Maintenance

When making notable changes to the config, update `README.md` to reflect them:
- Add new entries to **Notable Details** for custom overrides, workarounds, or non-obvious config.
- Update the **Components** table if a major component is added, removed, or replaced.
- Update the **Keybindings** table if keybindings are added or changed.
- Update the **Repository Structure** tree if files are added or removed.

## Change Review Checklist

1. Change is scoped to what was requested.
2. New files are imported in the appropriate `default.nix`.
3. Packages are in Home Manager unless system-level config is required.
4. No secrets or machine-specific hardcoded paths added.
5. Flake evaluates without errors.
6. `README.md` updated if the change is notable (see above).
