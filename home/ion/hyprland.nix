{ config, pkgs, ... }:
{
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
      ];

      # Autostart
      "exec-once" = [
	"swayosd-server"
        "hyprpaper"
        "waybar"
        "nm-applet --indicator"
      ];

      # Key bindings
      bind = [
        # Applications
        "$mod, Return, exec, kitty"
        "$mod, D, exec, bash -lc 'if pgrep -f \"(^|/)wofi( |$)\" >/dev/null; then pkill -f \"(^|/)wofi( |$)\"; else wofi --show drun & disown; fi'"
        "$mod, E, exec, thunar"
        "$mod, B, exec, firefox"
        "$mod, Q, killactive"

        # Workspaces: relative navigation
        "$mod, right, workspace,e+1"
        "$mod, left,  workspace, e-1"

        # Move focused window to adjacent workspace
        "$mod SHIFT, right, movetoworkspace, +1"
        "$mod SHIFT, left,  movetoworkspace, -1"

        # Quick jump to numbered workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"

        # Send focused window to numbered workspaces
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"

  	# Volume 
  	", XF86AudioRaiseVolume, exec, swayosd-client --output-volume +5"
  	", XF86AudioLowerVolume, exec, swayosd-client --output-volume -5"
  	", XF86AudioMute,        exec, swayosd-client --output-volume mute-toggle"

  	# Mic mute
  	", XF86AudioMicMute,     exec, swayosd-client --input-volume mute-toggle"

  	# Brightness 
  	", XF86MonBrightnessUp,   exec, swayosd-client --brightness +10"
  	", XF86MonBrightnessDown, exec, swayosd-client --brightness -10"
      ];
    };
  };
}
