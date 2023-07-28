{
  inputs,
  cell,
}: {
  default = {...}: {
    bee.modules.sshExample-default = {
      enable = true;
      openFirewall = true;
    };
  };
}
