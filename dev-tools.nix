{ config, pkgs, ... }:

  {
    environment.systemPackages = with pkgs; [
      # System info
      pciutils
      usbutils

      # Editors
      neovim
      vscode

      # Terminal
      kitty

      # Version control
      git
      gh
      lazygit
      delta

      # Shell prompt
      starship

      # File manager
      yazi

      # Modern CLI tools
      btop
      eza
      bat
      fzf
      zoxide
      ripgrep
      fd
      jq
      htop
      tealdeer

      # Security
      gnupg
      seahorse
    ];

    # SSH agent
   # programs.ssh.startAgent = true;

    # GPG agent
    #programs.gnupg.agent = {
    #  enable = true;
    #  enableSSHSupport = false;
    #};
  }
