{
  description = "NixOS configuration";

  inputs = {
    # Pinned to a release channel on purpose. There is no "latest stable" alias —
    # bump this by hand (~every 6 months) when the current release goes EOL.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Used only for packages broken on the stable channel (currently vscode:
    # 26.05's builder hardcodes a ripgrep path that moved in VS Code 1.122.0).
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    {
      nixosConfigurations = {
        zephyrus-g14 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/zephyrus-g14
            home-manager.nixosModules.home-manager
            {
              home-manager.backupFileExtension = "bak";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.sharedModules = [
                inputs.caelestia-shell.homeManagerModules.default
              ];
              home-manager.users.alex = ./home;
            }
          ];
        };
      };
    };
}
