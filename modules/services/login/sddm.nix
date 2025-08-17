{ ... }:
{
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "where_is_my_sddm_theme";
    };
    # Start Hyprland by default
    defaultSession = "hyprland";
  };
}
