{ ... }:
{
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
  services.displayManager.defaultSession = "hyprland";
  services.dbus.enable = true;
}
