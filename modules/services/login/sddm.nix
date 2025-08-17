{ pkgs, ... }:
{
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "where_is_my_sddm_theme";
      themePackage = pkgs.where-is-my-sddm-theme;
    };
    # Start Hyprland by default
    defaultSession = "hyprland";
  };
}
