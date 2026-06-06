{
  config,
  lib,
  pkgs,
  ...
}:
let
  homeDir = config.home.homeDirectory;
  cursorName = "Bibata-Modern-Ice";
  cursorSize = 24;
in
{
  home.packages = with pkgs; [
    # Niri companions
    xwayland-satellite
    grim
    slurp
    swappy

    # Tray apps / OSD
    blueman
    networkmanagerapplet
    brightnessctl
    swayosd

    # Clipboard
    wl-clip-persist
    cliphist
    wl-clipboard

    # Screenshots / color picker
    hyprshot
    hyprpicker
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    GDK_BACKEND = "wayland";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "niri";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };

  home.pointerCursor = {
    name = cursorName;
    size = cursorSize;
    package = pkgs.bibata-cursors;
    gtk.enable = true;
    x11.enable = true;
  };

  home.file."Pictures/wallpapers".source = ../../../wallpapers;

  xdg.configFile."niri/config.kdl".text = ''
    // --------------------------------------------------------------------
    //  Niri compositor configuration
    //  Layout, look and bindings adapted from the previous Hyprland setup.
    //  https://yalter.github.io/niri/Configuration:-Introduction
    // --------------------------------------------------------------------

    input {
        keyboard {
            xkb {
                layout "us,fr"
                options "grp:alt_shift_toggle"
            }
            numlock
        }

        touchpad {
            dwt
            natural-scroll
        }

        mouse {
            // accel-profile "flat"
        }

        focus-follows-mouse max-scroll-amount="0%"
    }

    output "HDMI-A-1" {
        mode "3440x1440@100.000"
        position x=0 y=0
        scale 1
    }
    output "DP-2" {
        mode "2560x1440@239.958"
        position x=3440 y=0
        scale 1
    }

    layout {
        gaps 8
        center-focused-column "never"

        preset-column-widths {
            proportion 0.333333
            proportion 0.500000
            proportion 0.666667
        }

        default-column-width { proportion 0.500000; }

        focus-ring {
            width 4
            active-color "#f5c2e7"
            inactive-color "#505050"
        }

        border {
            off
        }

        struts {
            // top 0
            // bottom 0
        }
    }

    cursor {
        xcursor-theme "${cursorName}"
        xcursor-size ${toString cursorSize}
    }

    hotkey-overlay {
        skip-at-startup
    }

    prefer-no-csd

    screenshot-path "~/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    animations {
        // off
    }

    // --------------------------------------------------------------------
    //  Window rules
    // --------------------------------------------------------------------
    window-rule {
        // Rounded corners on every window.
        geometry-corner-radius 16
        clip-to-geometry true
    }

    // Make sure overview backdrop uses the wallpaper layer (noctalia).
    layer-rule {
        match namespace="^noctalia-overview*"
        place-within-backdrop true
    }

    debug {
        // Lets noctalia activate windows via xdg-activation.
        honor-xdg-activation-with-invalid-serial
    }

    // --------------------------------------------------------------------
    //  Startup
    // --------------------------------------------------------------------
    spawn-at-startup "noctalia-shell"
    spawn-at-startup "swayosd-server"
    spawn-at-startup "blueman-applet"
    spawn-at-startup "nm-applet" "--indicator"
    spawn-at-startup "wl-clip-persist" "--clipboard" "both"
    spawn-at-startup "sh" "-c" "wl-paste --watch cliphist store"

    // --------------------------------------------------------------------
    //  Keybindings  (preserved from Hyprland setup; Mod = Super)
    // --------------------------------------------------------------------
    binds {
        //  --- Apps ---------------------------------------------------
        Mod+Return       { spawn "kitty"; }
        Mod+E            { spawn "thunar"; }
        Mod+B            { spawn "firefox"; }

        //  Launcher / wallpaper picker via noctalia-shell IPC.
        Mod+D            { spawn "noctalia-shell" "ipc" "call" "launcher" "toggle"; }
        Mod+W            { spawn "noctalia-shell" "ipc" "call" "controlCenter" "toggle"; }

        //  --- Window management --------------------------------------
        Mod+Q            { close-window; }
        Mod+F            { maximize-column; }
        Mod+Shift+F      { fullscreen-window; }
        Mod+V            { toggle-window-floating; }
        Mod+R            { switch-preset-column-width; }

        //  Column navigation.
        Mod+Left         { focus-column-left; }
        Mod+Right        { focus-column-right; }
        Mod+Shift+Left   { move-column-left; }
        Mod+Shift+Right  { move-column-right; }

        //  Workspace navigation.
        Mod+Up           { focus-workspace-up; }
        Mod+Down         { focus-workspace-down; }
        Mod+Shift+Up     { move-window-to-workspace-up; }
        Mod+Shift+Down   { move-window-to-workspace-down; }

        //  Vertical window navigation.
        Mod+J            { focus-window-or-workspace-down; }
        Mod+K            { focus-window-or-workspace-up; }
        Mod+Shift+J      { move-window-down-or-to-workspace-down; }
        Mod+Shift+K      { move-window-up-or-to-workspace-up; }

        //  Workspace 1..5
        Mod+1            { focus-workspace 1; }
        Mod+2            { focus-workspace 2; }
        Mod+3            { focus-workspace 3; }
        Mod+4            { focus-workspace 4; }
        Mod+5            { focus-workspace 5; }
        Mod+Shift+1      { move-column-to-workspace 1; }
        Mod+Shift+2      { move-column-to-workspace 2; }
        Mod+Shift+3      { move-column-to-workspace 3; }
        Mod+Shift+4      { move-column-to-workspace 4; }
        Mod+Shift+5      { move-column-to-workspace 5; }

        //  --- Screenshots --------------------------------------------
        //  Same layout as Hyprland: PRINT = output, Mod+PRINT = window,
        //  Mod+Shift+PRINT = interactive region.
        Print            { screenshot-screen; }
        Mod+Print        { screenshot-window; }
        Mod+Shift+Print  { screenshot; }

        //  --- Media / brightness keys --------------------------------
        XF86AudioRaiseVolume    allow-when-locked=true { spawn "swayosd-client" "--output-volume" "+5" "--max-volume" "100"; }
        XF86AudioLowerVolume    allow-when-locked=true { spawn "swayosd-client" "--output-volume" "-5" "--max-volume" "100"; }
        XF86AudioMute           allow-when-locked=true { spawn "swayosd-client" "--output-volume" "mute-toggle"; }
        XF86MonBrightnessUp     allow-when-locked=true { spawn "swayosd-client" "--brightness" "+10"; }
        XF86MonBrightnessDown   allow-when-locked=true { spawn "swayosd-client" "--brightness" "-10"; }

        //  --- Session ------------------------------------------------
        Mod+Shift+E      { quit; }
        Mod+Shift+P      { power-off-monitors; }
    }
  '';
}
