{ ... }:
{
  services.xserver.enable = true;
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  services.accounts-daemon.enable = true;
  services.dbus.enable = true;

  programs.dconf.profiles.gdm.databases = [
    {
      settings."org/gnome/login-screen" = {
        disable-user-list = false;
      };
    }
  ];
}
