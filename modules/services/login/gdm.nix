{ ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.displayManager.defaultSession = "hyprland";
  services.dbus.enable = true;
}
