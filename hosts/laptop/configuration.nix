{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/common.nix
    ../../modules/desktop/hyprland.nix
  ];

  system.stateVersion = "25.05";
}
