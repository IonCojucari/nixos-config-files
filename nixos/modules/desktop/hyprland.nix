{ pkgs, ... }:
{
  # Hyprland session
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Removable media / trash / network mounts, etc.
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
