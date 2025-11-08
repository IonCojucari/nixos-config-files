{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    hyprpaper
    networkmanagerapplet
    swayosd
    libcanberra-gtk3
  ];
  
  wayland.windowManager.hyprland.extraConfig = ''
    env = HYPRSHOT_DIR,/home/ion/Screenshots
  '';


  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    size = 24;
    package = pkgs.bibata-cursors;
  };

  
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/ion/Wallpapers/berserk_1.jpg
    wallpaper = ,/home/ion/Wallpapers/berserk_1.jpg
  '';


  
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # Rendered to ~/.config/hypr/hyprland.conf
    settings = {
      input = {
        kb_layout = "us,fr";
        kb_variant = "";
        kb_options = "grp:alt_shift_toggle";
      };

      # Variables
      "$mod" = "SUPER";

      # Monitors
      monitor = [
        "eDP-1,preferred,auto,1"
      ];

      # Workspaces
      workspace = [
        "1, monitor:eDP-1, default:true, persistent:true"
        "2, monitor:eDP-1, persistent:true"
        "3, monitor:eDP-1, persistent:true"
        "4, monitor:eDP-1, persistent:true"
        "5, monitor:eDP-1, persistent:true"
      ];

      # Smooth UI feel
      animations = {
        enabled = true;
        bezier = "easeOutQuint, 0.23, 1, 0.32, 1";
        animation = [
          "windows, 1, 7, easeOutQuint"
          "windowsOut, 1, 7, easeOutQuint, popin 80%"
          "border, 1, 10, easeOutQuint"
          "fade, 1, 7, easeOutQuint"
          "workspaces, 1, 6, easeOutQuint, slide"
        ];
      };

      # Autostart
      "exec-once" = [
        "swayosd-server"
        "caelestia shell -d"
        "nm-applet --indicator"
        "bash -lc 'for ws in 1 2 3 4 5; do hyprctl dispatch workspace $ws; done; hyprctl dispatch workspace 1'"
      ];
      
      # Multimedia keys
      binde = [
        ", XF86AudioRaiseVolume, exec, bash -lc 'swayosd-client --output-volume +5; canberra-gtk-play -i audio-volume-change >/dev/null 2>&1 &'"
        ", XF86AudioLowerVolume, exec, bash -lc 'swayosd-client --output-volume -5; canberra-gtk-play -i audio-volume-change >/dev/null 2>&1 &'"
        ", XF86AudioMute,        exec, bash -lc 'swayosd-client --output-volume mute-toggle; canberra-gtk-play -i audio-volume-muted >/dev/null 2>&1 &'"
      ];

      # Key bindings (press actions)
      bind = [
	# Applications
        "$mod, Return, exec, kitty"
        "$mod, D, exec, bash -lc 'if pgrep -f \"(^|/)wofi( |$)\" >/dev/null; then pkill -f wofi; else wofi --show drun; fi'"
        "$mod, E, exec, thunar"
        "$mod, B, exec, brave"
        "$mod, Q, killactive"

        # Workspaces: relative navigation
        "$mod, right, workspace, e+1"
        "$mod, left,  workspace, e-1"

        # Move focused window to adjacent workspace
        "$mod SHIFT, right, movetoworkspace, e+1"
        "$mod SHIFT, left,  movetoworkspace, e-1"

        # Quick jump to numbered workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        # Send focused window to numbered workspaces
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"

        # Mic mute
        ", XF86AudioMicMute,     exec, swayosd-client --input-volume mute-toggle"

        # Brightness
        ", XF86MonBrightnessUp,   exec, swayosd-client --brightness +10"
        ", XF86MonBrightnessDown, exec, swayosd-client --brightness -10"

        # Screenshots (Hyprshot)
        "$mod, PRINT, exec, hyprshot -m window"   # Screenshot active window
        ", PRINT, exec, hyprshot -m output"       # Screenshot entire monitor
        "$mod SHIFT, PRINT, exec, hyprshot -m region" # Screenshot selected region
      ];
    };
  };
}
