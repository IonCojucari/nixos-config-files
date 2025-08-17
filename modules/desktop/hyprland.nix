{ pkgs, ... }:
{
  # Hyprland session
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
