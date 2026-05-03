{ lib, pkgs, ... }:
{
  programs.virt-manager.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.runAsRoot = false;
  };

  security.polkit.enable = true;

  users.groups.ubridge = { };
  users.users.ion.extraGroups = lib.mkAfter [
    "libvirtd"
    "kvm"
    "ubridge"
  ];

  security.wrappers.ubridge = {
    owner = "root";
    group = "ubridge";
    source = "${pkgs.ubridge}/bin/ubridge";
    permissions = "u+rx,g+rx,o+rx";
    capabilities = "cap_net_admin,cap_net_raw=ep";
  };

  environment.systemPackages = with pkgs; [
    dynamips
    gns3-gui
    gns3-server
    libvirt
    ubridge
    vpcs
  ];
}
