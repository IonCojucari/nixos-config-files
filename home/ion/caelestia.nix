{ config, pkgs, ... }:

{
  programs.caelestia = {
    enable = true;

    # Optional systemd integration
    systemd = {
      enable = true; # or true if you want it to start via systemd
      target = "graphical-session.target";
      environment = [];
    };

    settings = {
      bar.status = {
        showBattery = false;
      };
      paths.wallpaperDir = "~/Pictures/Wallpapers";
    };

    cli = {
      enable = true; # Also adds caelestia-cli to PATH
      settings = {
        theme.enableGtk = false;
      };
    };
  };
}
