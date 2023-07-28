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
  in
    hive.growOn {
      inherit inputs nixpkgsConfig;
      cellsFrom = incl ./nix ["repo"];
      cellBlocks = [
        (std.blockTypes.nixago "configs")
        (std.blockTypes.devshells "shells")
      ];
    }
    (hive.grow {
      inherit inputs nixpkgsConfig;
      cellsFrom = incl ./nix ["core" "sshExample"];
      cellBlocks = [
        hive.blockTypes.nixosModules
        hive.blockTypes.nixosProfiles
        hive.blockTypes.nixosConfigurations
      ];
    })
    {
      nixosModules = hive.collect self "nixosModules";
      nixosProfiles = hive.collect self "nixosProfiles";
      nixosConfigurations = hive.collect self "nixosConfigurations";
    };
}
