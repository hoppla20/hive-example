{
  inputs,
  cell,
}: {
  default = {...}: {
    bee.modules.sshExample = {
      enable = true;
      openFirewall = true;
    };
  };
}
