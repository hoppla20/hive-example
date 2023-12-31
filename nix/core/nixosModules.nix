{
  inputs,
  cell,
}: {
  default = renamer: moduleName: {
    lib,
    config,
    ...
  }: let
    cfg = config.bee.modules.${moduleName};
  in {
    options = {
      package = lib.mkOption {
        type = lib.types.package;
        default = config.bee.pkgs.hello;
      };
    };

    config = {
      environment.systemPackages = [cfg.package];
    };
  };
}
