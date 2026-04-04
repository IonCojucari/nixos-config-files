{ pkgs, ... }:
{
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      monitor = [ ",preferred,auto,1" ];

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 0;
        layout = "master";
      };

      decoration = {
        rounding = 0;
        blur.enabled = false;
        shadow.enabled = false;
      };

      animations.enabled = false;

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        background_color = "rgb(000000)";
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      env = [
        "XCURSOR_SIZE,24"
      ];

      windowrulev2 = [
        "fullscreen,class:^(steam)$"
        "fullscreen,title:^(Steam)$"
        "suppressevent maximize,class:^(steam)$"
      ];

      bind = [
        "SUPER, Q, exit"
      ];

      "exec-once" = [
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE"
        "bash -lc 'steam -tenfoot; hyprctl dispatch exit'"
      ];
    };
  };
}
