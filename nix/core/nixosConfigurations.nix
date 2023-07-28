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
        inputs.nixosProfiles.sshExample_default
      ];
      extraModules = [
        inputs.nixosModules.sshExample_default
      ];

      profiles = ["core_default" "sshExample_default"];
    };
  };
}
