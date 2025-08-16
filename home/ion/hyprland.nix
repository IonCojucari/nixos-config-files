{ ... }:
{
  home.file.".config/hypr/hyprland.conf".text = ''
    $mod = SUPER

    # Autostart
    exec-once = hyprpaper
    exec-once = waybar
    exec-once = nm-applet --indicator

    # Binds
    bind = $mod, Return, exec, kitty
    bind = $mod, D, exec, wofi --show drun
    bind = $mod, E, exec, env QT_QPA_PLATFORM=wayland dolphin
    bind = $mod, Q, killactive
    bind = $mod, B, exec, firefox
  '';
}
