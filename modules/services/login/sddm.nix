{ ... }:
{
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "breeze";
    };
    # Start Hyprland by default
    defaultSession = "hyprland";
  };
}
