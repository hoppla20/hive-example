{
  description = "Hive Example";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hive = {
      url = "github:hoppla20/hive/implement-modules-and-profiles";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        haumea.follows = "std/dmerge/haumea";
        paisano.follows = "std/paisano";
      };
    };
    std = {
      url = "github:divnix/std/release/0.23";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    hive,
    std,
    ...
  } @ inputs:
    hive.growOn {
      inherit inputs;
      nixpkgsConfig = {
        allowUnfree = true;
      };
      cellsFrom = ./nix;
      cellBlocks = [
        (std.blockTypes.nixago "configs")
        (std.blockTypes.devshells "shells")
        hive.blockTypes.nixosModules
        hive.blockTypes.nixosProfiles
        hive.blockTypes.nixosConfigurations
      ];
    }
    {
      nixosModules = hive.collect self "nixosModules";
      nixosProfiles = hive.collect self "nixosProfiles";
      nixosConfigurations = hive.collect self "nixosConfigurations";
    };
}
