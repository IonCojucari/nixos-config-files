{ config, pkgs, ... }:
let
  wallpaperDir = "${config.home.homeDirectory}/Pictures/wallpapers";
  wallpaperFile = "${wallpaperDir}/wallpaper.png";
  initWallpaper = pkgs.writeShellScriptBin "init-wallpaper" ''
    #!/usr/bin/env bash
    if ! pgrep -x swww-daemon >/dev/null; then
      swww-daemon --no-cache &
      while ! swww query >/dev/null 2>&1; do
        sleep 0.1
      done
    fi

    swww img -t none "${wallpaperFile}" &
  '';
in
{
  home.packages = with pkgs; [
    networkmanagerapplet
    pamixer
    brightnessctl
    swayosd
    swww
    wl-clip-persist
    cliphist
    hyprpicker
    grimblast
    grim
    slurp
    hyprlock
  ] ++ [ initWallpaper ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
    DISABLE_QT5_COMPAT = "0";
    GDK_BACKEND = "wayland";
    ANKI_WAYLAND = "1";
    DIRENV_LOG_FORMAT = "";
    WLR_DRM_NO_ATOMIC = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";
    MOZ_ENABLE_WAYLAND = "1";
    WLR_BACKEND = "vulkan";
    WLR_RENDERER = "vulkan";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    GTK_THEME = "Colloid-Green-Dark-Gruvbox";
    GRIMBLAST_HIDE_CURSOR = "0";
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    size = 24;
    package = pkgs.bibata-cursors;
  };

  home.file."Pictures/wallpapers".source = ../../wallpapers;

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;

    extraConfig = ''
      env = HYPRSHOT_DIR,${config.home.homeDirectory}/Screenshots
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
        touchpad = { natural_scroll = true; };
      };

      "$mod" = "SUPER";
      "$mainMod" = "SUPER";

      monitor = [
        ",preferred,auto,1"
      ];


      workspace = [
        "1, default:true, persistent:true"
        "2, persistent:true"
        "3, persistent:true"
        "4, persistent:true"
        "5, persistent:true"
      ];

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
        new_window_takes_over_fullscreen = 2;
        middle_click_paste = false;
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
          "workspaces,  1, 4,   easeOutCubic, fade"
        ];
      };

      "exec-once" = [
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "swayosd-server"
        "nm-applet --indicator"
        "wl-clip-persist --clipboard both"
        "wl-paste --watch cliphist store"
        "hyprctl setcursor Bibata-Modern-Ice 24"
        "init-wallpaper"
        "bash -lc 'for ws in 1 2 3 4 5; do hyprctl dispatch workspace $ws; done; hyprctl dispatch workspace 1'"
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
        "$mod, B, exec, brave"
        "$mod, Q, killactive"

        "$mod, right, workspace, e+1"
        "$mod, left,  workspace, e-1"

        "$mod SHIFT, right, movetoworkspace, e+1"
        "$mod SHIFT, left,  movetoworkspace, e-1"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"

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
          font_family = "JetBrainsMono Nerd Font";
          shadow_passes = 3;
          color = "rgba(235, 219, 178, 0.9)";
          position = "0, -150";
          halign = "center";
          valign = "top";
        }
        {
          text = ''cmd[update:1000] echo "- $(date +'%A, %B %d') -" '';
          font_size = 18;
          font_family = "JetBrainsMono Nerd Font";
          shadow_passes = 3;
          color = "rgba(235, 219, 178, 0.9)";
          position = "0, -350";
          halign = "center";
          valign = "top";
        }
        {
          text = "  $USER";
          font_size = 15;
          font_family = "JetBrainsMono Nerd Font";
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
          font_family = "JetBrainsMono Nerd Font";
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
