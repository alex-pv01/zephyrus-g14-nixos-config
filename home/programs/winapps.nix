{ pkgs, inputs, ... }:

{
  home.packages = [
    inputs.winapps.packages.${pkgs.system}.winapps
    inputs.winapps.packages.${pkgs.system}.winapps-launcher
    # FreeRDP 3 is what winapps shells out to for the seamless windows
    pkgs.freerdp
  ];
}
