{ ... }:
{
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "chili";
    };
    defaultSession = "hyprland"; # Set Hyprland as default session
  };
}
