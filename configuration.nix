  { config, pkgs, ... }:

  {
    imports =
      [
        ./hardware-configuration.nix
        ./zephyrus-g14.nix
        #./hyprland.nix
        ./office-tools.nix
        ./dev-tools.nix
        ./creative.nix
        ./music.nix
        ./proton.nix
        ./gaming.nix
        ./ai.nix
	./theme.nix
	./fonts.nix
      ];

	nix.settings.experimental-features = ["nix-command" "flakes"];

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Use latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "zephyrus-g14";
    networking.networkmanager.enable = true;

    # Time zone
    time.timeZone = "Europe/Copenhagen";

    # Locale
    i18n.defaultLocale = "ca_ES.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "ca_ES.UTF-8";
      LC_IDENTIFICATION = "ca_ES.UTF-8";
      LC_MEASUREMENT = "ca_ES.UTF-8";
      LC_MONETARY = "ca_ES.UTF-8";
      LC_NAME = "ca_ES.UTF-8";
      LC_NUMERIC = "ca_ES.UTF-8";
      LC_PAPER = "ca_ES.UTF-8";
      LC_TELEPHONE = "ca_ES.UTF-8";
      LC_TIME = "ca_ES.UTF-8";
    };

    # GNOME as fallback desktop (GDM disabled — greetd is used instead from niri.nix)
    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    # Keyboard layout
    services.xserver.xkb = {
      layout = "es";
      variant = "cat";
    };
    console.keyMap = "es";

    # Printing
    services.printing.enable = true;

    # Sound (pipewire)
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # User
    users.users.alex = {
      isNormalUser = true;
      description = "Alex";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    # Firefox
    programs.firefox.enable = true;

    # Unfree packages
    nixpkgs.config.allowUnfree = true;

    # System-wide packages
    environment.systemPackages = with pkgs; [
      obsidian
      git
      neovim
      wget
    ];

    environment.variables.EDITOR = "neovim";

    system.stateVersion = "25.11";
  }
