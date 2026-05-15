{ config, pkgs, ... }: 

{
	networking.firewall.checkReversePath = "loose";
    	
	environment.systemPackages = with pkgs; [ 
        	protonvpn-gui
	];   
}
