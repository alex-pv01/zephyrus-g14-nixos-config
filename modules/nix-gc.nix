{ ... }:

{
  # Weekly garbage collection of unreferenced store paths and old generations.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
    randomizedDelaySec = "30min";
  };

  # Deduplicate identical store files via hardlinks (runs as a separate timer
  # rather than auto-optimise-store, which slows down every build).
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  # Cap boot menu entries so /boot does not accumulate kernels indefinitely.
  boot.loader.systemd-boot.configurationLimit = 15;
}
