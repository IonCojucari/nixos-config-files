{ ... }:
{

  wayland.windowManager.hyprland = {
    xwayland.enable = true;
  };


  home.file.".config/hypr/hyprland.conf".text = ''
    $mod = SUPER

    monitor = eDP-1,preferred,auto,1

    # Autostart
    exec-once = hyprpaper
    exec-once = waybar
    exec-once = nm-applet --indicator

    # Binds
    bind = $mod, Return, exec, kitty
    bind = $mod, D, exec, wofi --show drun
    bind = $mod, E, exec, thunar
    bind = $mod, Q, killactive
    bind = $mod, B, exec, firefox
  '';
}
