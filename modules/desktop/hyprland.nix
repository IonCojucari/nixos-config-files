{ pkgs, ... }:
{
  # Hyprland session
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Removable media / trash / network mounts are configured globally
}
