{
  inputs,
  cell,
}: {
  default = {config, ...}: {
    bee = {
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs;
      home = inputs.home-manager;
    };
  };
}
