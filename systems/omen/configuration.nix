{ config, pkgs, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../nixos/configuration.nix
    ];
  networking.hostName = "omen"; # Define your hostname.

# Use NVIDIA proprietary driver
  services.xserver.videoDrivers = [ "nvidia" ];
  
  hardware.nvidia = {
    modesetting.enable = true;
  
    powerManagement.enable = true;
    powerManagement.finegrained = true;
  
    open = false; # proprietary driver (recommended)
  
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
  
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
