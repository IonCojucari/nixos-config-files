{ ... }:
{
  services.xserver.enable = true;
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.accounts-daemon.enable = true;
  services.dbus.enable = true;
}
