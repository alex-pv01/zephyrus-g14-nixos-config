{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    obsidian
    zotero
    zoom-us
    libreoffice-qt
    hunspell
    hunspellDicts.en_GB-ise
    hunspellDicts.es_ES
    hunspellDicts.da_DK
    texlive.combined.scheme-full
  ];
}
