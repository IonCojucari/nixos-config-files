{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/common.nix
    ../../modules/services/login/gdm.nix
    ../../modules/desktop/plumbing.nix
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/plasma.nix
    ../../modules/programs/common.nix
    ../../modules/desktop/hyprland.nix
  ];

  system.stateVersion = "25.05";
}
