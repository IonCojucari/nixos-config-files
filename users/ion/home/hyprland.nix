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
  fontFamily = "JetBrainsMono Nerd Font";
  workspaces = map toString (lib.range 1 5);
  wallpaperDir = "${homeDir}/Pictures/wallpapers";
  wallpaperFile = "${wallpaperDir}/wallpaper.png";
  initWorkspaces = "bash -lc 'for ws in ${lib.concatStringsSep " " workspaces}; do hyprctl dispatch workspace $ws; done; hyprctl dispatch workspace 1'";
  workspaceRules = map (
    ws: "${ws}${lib.optionalString (ws == "1") ", default:true"}, persistent:true"
  ) workspaces;
  workspaceBinds =
    modifier: dispatcher: map (ws: "$mod${modifier}, ${ws}, ${dispatcher}, ${ws}") workspaces;
  initWallpaper = pkgs.writeShellScriptBin "init-wallpaper" ''
    if ! pgrep -x awww-daemon >/dev/null; then
      awww-daemon --no-cache &
      while ! awww query >/dev/null 2>&1; do
        sleep 0.1
      done
    fi

    awww img -t none "${wallpaperFile}" &
  '';
in
{
  home.packages = with pkgs; [
    networkmanagerapplet
    brightnessctl
    swayosd
    awww
    wl-clip-persist
    cliphist
    hyprpicker
    hyprshot
    grim
    slurp
    initWallpaper
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    GDK_BACKEND = "wayland";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };

  home.pointerCursor = {
    name = cursorName;
    size = cursorSize;
    package = pkgs.bibata-cursors;
  };

  home.file."Pictures/wallpapers".source = ../../../wallpapers;

  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      env = HYPRSHOT_DIR,${homeDir}/Screenshots
    '';

    settings = {
      input = {
        kb_layout = "us,fr";
        kb_options = "grp:alt_shift_toggle";
        numlock_by_default = true;
        follow_mouse = 1;
        float_switch_override_focus = 1;
        mouse_refocus = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      "$mod" = "SUPER";

      monitor = [
        "DP-1,3440x1440@120,0x0,1"
        "DP-2,preferred,3440x0,1"
        ",preferred,auto,1"
      ];

      workspace = workspaceRules;

      general = {
        layout = "dwindle";
        gaps_in = 6;
        gaps_out = 12;
        border_size = 2;
        "col.active_border" = "rgb(98971A) rgb(CC241D) 45deg";
        "col.inactive_border" = "0x00000000";
      };

      misc = {
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        focus_on_activate = true;
        on_focus_under_fullscreen = 2;
        middle_click_paste = false;
        vrr = 3;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      dwindle = {
        force_split = 2;
        special_scale_factor = 1.0;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = "yes";
        preserve_split = "yes";
      };

      decoration = {
        rounding = 0;
        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          brightness = 1;
          contrast = 1.4;
          ignore_opacity = true;
          noise = 0;
          new_optimizations = true;
          xray = true;
        };

        shadow = {
          enabled = true;
          ignore_window = true;
          offset = "0 2";
          range = 20;
          render_power = 3;
          color = "rgba(00000055)";
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "fade_curve, 0, 0.55, 0.45, 1"
        ];

        animation = [
          "windowsIn,   0, 4, easeOutCubic,  popin 20%"
          "windowsOut,  0, 4, fluent_decel,  popin 80%"
          "windowsMove, 1, 2, fluent_decel, slide"
          "fadeIn,      1, 3,   fade_curve"
          "fadeOut,     1, 3,   fade_curve"
          "fadeSwitch,  0, 1,   easeOutCirc"
          "fadeShadow,  1, 10,  easeOutCirc"
          "fadeDim,     1, 4,   fluent_decel"
          "workspaces,  1, 4,   easeOutCubic, slide"
        ];
      };

      "exec-once" = [
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "swayosd-server"
        "nm-applet --indicator"
        "wl-clip-persist --clipboard both"
        "wl-paste --watch cliphist store"
        "hyprctl setcursor ${cursorName} ${toString cursorSize}"
        "init-wallpaper"
        initWorkspaces
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume +5 --max-volume 100"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume -5 --max-volume 100"
        ", XF86AudioMute,        exec, swayosd-client --output-volume mute-toggle"
        ", XF86MonBrightnessUp,   exec, swayosd-client --brightness +10"
        ", XF86MonBrightnessDown, exec, swayosd-client --brightness -10"
      ];

      bind = [
        "$mod, Return, exec, kitty"
        "$mod, E, exec, thunar"
        "$mod, B, exec, firefox"
        "$mod, Q, killactive"

        "$mod, right, workspace, e+1"
        "$mod, left,  workspace, e-1"

        "$mod SHIFT, right, movetoworkspace, e+1"
        "$mod SHIFT, left,  movetoworkspace, e-1"
      ]
      ++ workspaceBinds "" "workspace"
      ++ workspaceBinds " SHIFT" "movetoworkspace"
      ++ [
        "$mod, PRINT, exec, hyprshot -m window"
        ", PRINT, exec, hyprshot -m output"
        "$mod SHIFT, PRINT, exec, hyprshot -m region"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindl = [
        "$mod, D, exec, bash -lc 'if pgrep -x rofi >/dev/null || pgrep -x rofi-wayland >/dev/null; then pkill -x rofi || true; pkill -x rofi-wayland || true; else rofi -show drun; fi'"
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        fractional_scaling = 0;
      };

      background = [
        {
          path = "${wallpaperFile}";
          color = "rgba(29, 32, 33, 255)";
          blur_passes = 2;
        }
      ];

      shape = [
        {
          size = "300, 50";
          rounding = 0;
          border_size = 2;
          color = "rgba(102, 92, 84, 0.33)";
          border_color = "rgba(168, 153, 132, 0.95)";
          position = "0, 270";
          halign = "center";
          valign = "bottom";
        }
      ];

      label = [
        {
          text = ''cmd[update:1000] echo "$(date +'%k:%M')"'';
          font_size = 115;
          font_family = fontFamily;
          shadow_passes = 3;
          color = "rgba(235, 219, 178, 0.9)";
          position = "0, -150";
          halign = "center";
          valign = "top";
        }
        {
          text = ''cmd[update:1000] echo "- $(date +'%A, %B %d') -" '';
          font_size = 18;
          font_family = fontFamily;
          shadow_passes = 3;
          color = "rgba(235, 219, 178, 0.9)";
          position = "0, -350";
          halign = "center";
          valign = "top";
        }
        {
          text = "  $USER";
          font_size = 15;
          font_family = fontFamily;
          color = "rgba(235, 219, 178, 1)";
          position = "0, 284";
          halign = "center";
          valign = "bottom";
        }
      ];

      input-field = [
        {
          size = "300, 50";
          rounding = 0;
          outline_thickness = 2;
          dots_spacing = 0.4;
          font_color = "rgba(235, 219, 178, 0.9)";
          font_family = fontFamily;
          outer_color = "rgba(168, 153, 132, 0.95)";
          inner_color = "rgba(102, 92, 84, 0.33)";
          check_color = "rgba(152, 151, 26, 0.95)";
          fail_color = "rgba(204, 36, 29, 0.95)";
          capslock_color = "rgba(215, 153, 33, 0.95)";
          bothlock_color = "rgba(215, 153, 33, 0.95)";
          hide_input = false;
          fade_on_empty = false;
          placeholder_text = ''<i><span foreground="#fbf1c7">Enter Password</span></i>'';
          position = "0, 200";
          halign = "center";
          valign = "bottom";
        }
      ];

      animation = [ "inputFieldColors, 0" ];
    };
  };
}
