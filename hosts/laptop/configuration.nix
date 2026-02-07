{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hosts/common.nix
  ];

  system.stateVersion = "25.05";
}
