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
        inputs.nixosProfiles.sshExample-default
      ];
      extraModules = [
        inputs.nixosModules.sshExample-default
      ];

      profiles = ["core-default" "sshExample-default"];
    };
  };
}
