{ lib, ... }:
{
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  services.lact.enable = true;
  hardware.amdgpu.overdrive.enable = true;

  imports = [
    ./hardware-configuration.nix
    ../../modules/system/common.nix
    ../../modules/services/login/gdm.nix
    ../../modules/desktop/plumbing.nix
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/plasma.nix
    ../../modules/programs/common.nix
    ../../modules/programs/gaming.nix
    ../../modules/programs/network-lab.nix
    ../../modules/desktop/hyprland.nix
  ];

  nix.settings.trusted-users = [ "root" "ion" ];

  # Users
  users.users.ion.extraGroups = lib.mkAfter [
    "render"
  ];

  users.users.assma.extraGroups = lib.mkAfter [ "render" ];

  hardware.graphics.enable32Bit = true;

  system.stateVersion = "25.05";
}
