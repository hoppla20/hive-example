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
    incl = {
      url = "github:divnix/incl";
      inputs.nixlib.follows = "std/dmerge/haumea/nixpkgs";
    };
  };

  outputs = {
    self,
    hive,
    std,
    incl,
    ...
  } @ inputs: let
    nixpkgsConfig = {
      allowUnfree = true;
    };

    l = inputs.nixpkgs.lib // builtins;
    blockTypes = l.attrsets.mergeAttrsList [std.blockTypes hive.blockTypes];

    collect =
      hive.collect
      // {
        renamer = cell: target: "${cell}_${target}";
      };

    outputNixosModules = collect self "nixosModules";
    outputNixosProfiles = collect self "nixosProfiles";
    outputNixosConfigurations = collect self "nixosConfigurations";
  in
    hive.growOn {
      inherit nixpkgsConfig;
      inputs =
        inputs
        // {
          nixosModules = outputNixosModules;
          nixosProfiles = outputNixosProfiles;
        };
      cellsFrom = ./nix;
      cellBlocks = with blockTypes; [
        (nixago "configs")
        (devshells "shells")
        nixosModules
        nixosProfiles
        nixosConfigurations
      ];
    }
    {
      nixosModules = outputNixosModules;
      nixosProfiles = outputNixosProfiles;
      nixosConfigurations = outputNixosConfigurations;
    };
}
