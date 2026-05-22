{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Editors
    neovim
    vscode

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
    uv

    # Web development
    nodejs

    # Data science
    kaggle

    # Remote access
    teleport
    openconnect

    # Security
    gnupg
    seahorse

    # Misc
    neofetch
    cowsay
    file
    which
    gnused
    gnutar
    gawk
    nix-output-monitor
  ];

  programs.tmux = {
    enable = true;
    package = pkgs.tmux.overrideAttrs (old: {
      version = "3.7-unstable";
      src = pkgs.fetchFromGitHub {
        owner = "tmux";
        repo = "tmux";
        rev = "634e9d6213b827d8ed93b8179f32cbb76823b619";
        hash = "sha256-gOmCGekxcYkxXPcX9thIt3hbsqg5jQo2EWdl0XVVnik=";
      };
      patches = [ ];
    });
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
