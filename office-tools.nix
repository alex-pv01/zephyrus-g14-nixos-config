{ config, pkgs, ... }: 

{
    	environment.systemPackages = with pkgs; [ 
        	libreoffice-qt
		hunspell
		hunspellDicts.en_GB-ise
		hunspellDicts.es_ES
		hunspellDicts.da_DK
	];   
}
