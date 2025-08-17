{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # Rendered to ~/.config/hypr/hyprland.conf
    settings = {
      # variables
      "$mod" = "SUPER";

      # monitors
      monitor = [ "eDP-1,preferred,auto,1" ];

      # autostart (repeats -> list)
      "exec-once" = [
        "hyprpaper"
        "waybar"
        "nm-applet --indicator"
      ];

      # keybinds (repeats -> list)
      bind = [
        "$mod, Return, exec, kitty"
        "$mod, D, exec, wofi --show drun"
        "$mod, E, exec, thunar"
        "$mod, Q, killactive"
        "$mod, B, exec, firefox"
      ];
    };
  };
}
