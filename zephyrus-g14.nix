{ config, pkgs, ... }: 

{
	# AMD + NVIDIA hybrid
	hardware.nvidia = {
  		modesetting.enable = true;
  		powerManagement.enable = true;
  		powerManagement.finegrained = true;
  		open = true;
  		nvidiaSettings = true;
  		package = config.boot.kernelPackages.nvidiaPackages.stable;

  		prime = {
    			offload = {
      				enable = true;
      				enableOffloadCmd = true;
    			};
    			amdgpuBusId = "PCI:4@0:0:0";
    			nvidiaBusId = "PCI:1@0:0:0";
  		};
	};

	services.xserver.videoDrivers = [
 		"amdgpu"
		"nvidia" 
	];

	boot.kernelParams = [ "nvidia.NVreg_TemporaryFilePath=/var/tmp" ];

	# Asusctl and Supergfxctl
    	services = { 
        	supergfxd = {
            		enable = true;
            		# gfx-mode = "Integrated";
            		# gfx-vfio-enable = true;
        	};
		asusd = {
			enable = true;
			enableUserService = true;
		};
	};   
}
