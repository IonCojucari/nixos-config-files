{ ... }:
{
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "chili";
    };
    # Start Hyprland by default
    defaultSession = "hyprland";
  };
  services.dbus.enable = true;

}
