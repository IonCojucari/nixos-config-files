{ ... }:
{
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "astronaut";
      settings = {
        General = {
          EnableHiDPI = true;
        };
      };
    };
    # Start Hyprland by default
    defaultSession = "hyprland";
  };
  services.dbus.enable = true;

}
