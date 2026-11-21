{ config, pkgs, inputs, ... }:

let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };
in
{
  home.packages = with pkgs; [
    # Editors
    neovim
    # From unstable: 26.05's vscode builder removes a bundled ripgrep at a path
    # that moved in VS Code 1.122.0, so the stable package fails to build.
    pkgs-unstable.vscode

    # Version control
    git
    gh
    lazygit
    delta

    # File managers
    yazi
    nnn

    # Modern CLI tools
    htop
    eza
    bat
    fzf
    zoxide
    ripgrep
    fd
    jq
    yq-go
    tealdeer
    tree
    glow

    # Archives
    zip
    xz
    unzip
    p7zip
    zstd

    # Networking
    wget
    mtr
    iperf3
    dnsutils
    ldns
    aria2
    socat
    nmap
    ipcalc

    # System info & monitoring
    pciutils
    usbutils
    iotop
    iftop
    sysstat
    lm_sensors
    ethtool
    strace
    ltrace
    lsof

    # Terminal multiplexer (managed below via programs.tmux)

    # Python
    python3
    uv

    # Web development
    nodejs

    # Data science
    kaggle

    # Cloud storage
    s3cmd

    # Remote access
    teleport
    openconnect

    # Security
    gnupg
    seahorse

    # Misc
    fastfetch # replaces neofetch, removed from nixpkgs (unmaintained upstream)
    cowsay
    file
    which
    gnused
    gnutar
    gawk
    nix-output-monitor
  ];

  programs.tmux = {
    # Was pinned to git master for focus-follows-mouse; that shipped in tmux 3.7,
    # so the plain nixpkgs package (3.7b) is used again.
    enable = true;
    mouse = true;
    historyLimit = 10000;
    extraConfig = ''
      set -g focus-follows-mouse on
    '';
  };

  programs.btop = {
    enable = true;
    package = pkgs.btop.override { cudaSupport = true; };
    settings = {
      color_theme = "caelestia";
      shown_boxes = "cpu mem net proc gpu0";
    };
  };
}
