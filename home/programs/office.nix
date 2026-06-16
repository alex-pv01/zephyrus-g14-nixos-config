{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    obsidian
    zotero
    libreoffice-qt
    hunspell
    hunspellDicts.en_GB-ise
    hunspellDicts.es_ES
    hunspellDicts.da_DK
  ];
}
