{
  inputs,
  cell,
}: {
  default = {
    lib,
    config,
    ...
  }: let
    cfg = config.bee.modules.core;
  in {
    options.bee.modules.core = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };

      package = lib.mkOption {
        type = lib.types.package;
        default = config.bee.pkgs.hello;
      };
    };

    config = lib.mkIf cfg.enable {
      environment.systemPackages = [cfg.package];
    };
  };
}
