{
  inputs,
  cell,
}: {
  default = {
    lib,
    config,
    options,
    ...
  }: let
    cfg = config.bee.modules.sshExample;
  in {
    options.bee.modules.sshExample = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };

      openFirewall = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };

    config = lib.mkIf cfg.enable {
      services.openssh = {
        enable = true;
        openFirewall = cfg.openFirewall;
      };
    };
  };
}
