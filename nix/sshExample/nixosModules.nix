{
  inputs,
  cell,
}: {
  default = moduleName: {
    lib,
    config,
    options,
    ...
  }: let
    cfg = config.bee.modules.${moduleName};
  in {
    options = {
      openFirewall = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };

    config = {
      services.openssh = {
        enable = true;
        openFirewall = cfg.openFirewall;
      };
    };
  };
}
