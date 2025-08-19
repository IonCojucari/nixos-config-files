{ pkgs, ... }:
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
  environment.systemPackages = [ pkgs.sddm-chili-theme ];
  services.dbus.enable = true;
}
