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
    btop
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

    # Terminal multiplexer
    tmux

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
}
