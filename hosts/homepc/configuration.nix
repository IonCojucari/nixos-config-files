{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/common.nix
    ../../modules/services/login/gdm.nix
    ../../modules/desktop/plumbing.nix
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/plasma.nix
    ../../modules/desktop/niri.nix
    ../../modules/programs/common.nix
    ../../modules/programs/gaming.nix
    ../../modules/programs/network-lab.nix
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.lact.enable = true;
  hardware.amdgpu.overdrive.enable = true;
  hardware.graphics.enable32Bit = true;

  nix.settings.trusted-users = [ "root" "ion" ];

  system.stateVersion = "25.05";
}
