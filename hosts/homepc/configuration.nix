{ lib, pkgs, ... }:
{
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  imports = [
    ./hardware-configuration.nix
    ../../modules/hosts/common.nix
  ];

  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.runAsRoot = false;
  };

  nix.settings.trusted-users = [ "root" "ion" ];

  # group required for ubridge wrapper
  users.groups.ubridge = { };

  # Users
  users.users.ion.extraGroups = lib.mkAfter [
    "render"
    "libvirtd"
    "kvm"
    "ubridge"
  ];

  # create ubridge wrapper with capabilities
  security.wrappers.ubridge = {
    owner = "root";
    group = "ubridge";
    source = "${pkgs.ubridge}/bin/ubridge";
    permissions = "u+rx,g+rx,o+rx";
    capabilities = "cap_net_admin,cap_net_raw=ep";
  };

  security.polkit.enable = true;

  hardware.graphics.enable32Bit = true;

  boot.kernelModules = [ "kvm-amd" ];

  system.stateVersion = "25.05";
}
