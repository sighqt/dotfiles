{ config, pkgs, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../nixos/configuration.nix
    ];
  networking.hostName = "dev-one"; # Define your hostname.
  
  # Loads the drivers for AMD GPUs on boot
  services.xserver.videoDrivers = [ "amdgpu" "radeon" ];
  boot.initrd.kernelModules = [ "amdgpu" "radeon" ];

}
