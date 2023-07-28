{
  inputs,
  cell,
}: {
  default = {
    bee = {
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs;
      home = inputs.home-manager;

      extraProfiles = [
        inputs.cells.sshExample.nixosProfiles.default
      ];
      extraModules = [
        inputs.cells.sshExample.nixosModules.default
      ];
      profiles = ["core-default"];
    };
  };
}
