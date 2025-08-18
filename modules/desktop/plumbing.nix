{ ... }:
{
  # Enable removable media, trash, and network mounts
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;
}
