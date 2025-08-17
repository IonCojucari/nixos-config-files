{ pkgs, ... }:
{
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha";
      extraPackages = [ pkgs.catppuccin-sddm ];
    };
    # Start Hyprland by default
    defaultSession = "hyprland";
  };
}
