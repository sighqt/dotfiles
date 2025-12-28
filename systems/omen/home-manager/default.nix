{ pkgs, inputs, ... }:
{
  imports = [
    ../../../home-manager/home.nix
  ];

  home.stateVersion = "25.11";
}
