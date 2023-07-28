{
  inputs,
  cell,
}: {
  default = targetName: {...}: {
    bee.modules.${targetName "default"} = {
      enable = true;
      openFirewall = true;
    };
  };
}
