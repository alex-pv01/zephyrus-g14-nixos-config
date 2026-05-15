{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/zephyrus-g14.nix
    ../../modules/hyprland.nix

    ../../modules/theme.nix
    ../../modules/fonts.nix
    ../../modules/music.nix
    ../../modules/gaming.nix
    ../../modules/proton.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # GNOME as fallback desktop
  services.xserver.enable = true;
  services.desktopManager.gnome.enable = true;

  # SDDM display manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.displayManager.defaultSession = "hyprland";

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

  environment.variables.EDITOR = "neovim";

  system.stateVersion = "25.11";
}
