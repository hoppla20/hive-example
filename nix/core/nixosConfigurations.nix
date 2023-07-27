{
  inputs,
  cell,
}: {
  example = {config, ...}: {
    bee = {
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs;
      home = inputs.home-manager;

      profiles = ["core-example"];
    };
  };
}
