{ pkgs, ... }:
{
  services.greetd = {
    enable = true;
    package = pkgs.greetd.qtgreet;
    settings = {
      default_session = {
        command = "Hyprland";
        user = "ion";
      };
    };
  };
  services.dbus.enable = true;

}
