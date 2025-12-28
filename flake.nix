{
  description = "one flake to rule them all";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix-themes.url = "github:eureka-cpu/helix-themes.nix";
  };

  outputs = { nixpkgs, home-manager, ... } @inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        dev-one = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./systems/dev-one/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs; };
                users.sighqt = ./systems/dev-one/home-manager;
              };
            }
          ];
        };
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
    };
}
