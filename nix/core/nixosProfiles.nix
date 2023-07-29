{
  inputs,
  cell,
}: {
  default = renamer: {...}: {
    bee.modules.${renamer "default"}.enable = true;
  };
}
