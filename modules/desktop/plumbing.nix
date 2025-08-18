{ ... }:
{
  # Enable removable media and mounts
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;
}
