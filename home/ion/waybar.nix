{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    pamixer
    cava
    playerctl
  ];

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    systemd.enable = false;

    style = ''
      * {
        padding: 0;
        margin: 0;
        min-height: 0;
        border-radius: 0;
        border: none;
        text-shadow: none;
        transition: none;
        box-shadow: none;
      }

      window#waybar {
        background: none;
        color: #000000;
        margin-top: 15px;
        margin-left: 15px;
        margin-right: 15px;
      }

      window#waybar.hidden { opacity: 1; }

      #custom-launcher,
      #window,
      #tray,
      #cpu,
      #temperature,
      #backlight,
      #memory,
      #cava,
      #mpris,
      #network,
      #pulseaudio,
      #pulseaudio.muted,
      #battery,
      #battery.critical,
      #battery.warning,
      #clock,
      #group-sound-bright-network,
      #group-sys-stats,
      #group-media {
        font-family: JetBrainsMono Nerd Font;
        font-size: 18px;
        font-weight: bold;
        background: none;
        margin: 0 6px;
        padding: 0 4px;
        color: #000000;
      }

      #cava {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
        padding: 0 6px;
        color: #000000;
      }

      #mpris {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
        padding: 0 6px;
        color: #000000;
      }

      #group-media {
        background: none;
        padding: 0 4px;
        margin: 0;
        color: #000000;
      }

      #group-media > * {
        padding: 0 4px;
      }

      #workspaces {
        padding: 0 2px;
        background: transparent;
      }

      #workspaces button {
        font-size: 0;
        min-width: 20px;
        min-height: 20px;
        padding: 0;
        margin: 0 6px;
        border-radius: 3px;
        background: transparent;
        border: 2px solid #000000;
      }

      #workspaces button:hover   { border-color: #000000; background: #000000; }
      #workspaces button.active  { background: #000000; border-color: #000000; }
      #workspaces button.urgent  { background: #000000; border-color: #000000; }

      #tray { padding: 0 6px; }

      #custom-powermenu {
        background: transparent;
        border: none;
        color: #000000;
        font-size: 26px;
        padding: 0 8px;
      }

      #custom-powermenu:hover {
        color: #000000;
      }
    '';

    settings = [
      {
        layer = "top";
        position = "top";

        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
          "group/sys-stats"
          "mpd"
        ];

        modules-center = [
          "clock"
          "tray"
        ];

        modules-right = [
          "group/media"                # <-- unified cava + mpris
          "group/sound-bright-network"
          "battery"
          "custom/powermenu"
        ];

        "custom/launcher" = {
          format = " ";
          on-click = "pkill wofi || wofi --show drun";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          persistent_workspaces = { "*" = [ "1" "2" "3" "4" ]; };
          on-click = "hyprctl dispatch workspace {name}";
          format = "{icon}";
          format-icons = { default = "●"; active = "●"; urgent = "●"; };
          all-outputs = true;
          active-only = false;
        };

        "group/sys-stats" = {
          orientation = "horizontal";
          modules = [ "cpu" "temperature" "memory" ];
        };

        cpu = {
          interval = 1;
          format = "󰍛 {usage}%";
        };

        temperature = {
          format = " {temperatureC}°C";
          critical-threshold = 80;
        };

        memory = {
          interval = 1;
          format = "󰻠 {percentage}%";
          states = { warning = 85; };
        };

        cava = {
          framerate = 30;
          autosens = 1;
          bars = 18;
          method = "pulse"; # or "pipewire"
          source = "auto";
          stereo = true;
          reverse = false;
          hide_on_silence = true;
          sleep_timer = 3;
          input_delay = 1;
          bar_delimiter = 0;
          "format-icons" = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        };

        mpris = {
          format = "{artist} - {title}";
          format-paused = "⏸ {artist} - {title}";
          format-stopped = "⏹";
          max-length = 35;
          tooltip = true;
          tooltip-format = "{player}: {artist} - {title}";
        };

        "group/media" = {
          orientation = "horizontal";
          modules = [ "cava" "mpris" ];
        };

        pulseaudio = {
          scroll-step = 1;
          format = " {volume}%";
          format-muted = "󰖁 Muted";
          on-click = "pamixer -t";
          tooltip = false;
        };

        backlight = {
          format = "󰃠 {percent}%";
          interval = 2;
          tooltip = true;
        };

        network = {
          format-disconnected = "󰯡";
          format-ethernet = "󰒢";
          format-wifi = "󰖩 {essid}";
          interval = 3;
          tooltip = false;
        };

        "group/sound-bright-network" = {
          orientation = "horizontal";
          modules = [ "pulseaudio" "backlight" "network" ];
        };

        clock = {
          interval = 1;
          format = "{:%H:%M}";
          tooltip = true;
          tooltip-format = "{:%A, %d %B %Y}\n<tt>{calendar}</tt>";
        };

        battery = {
          interval = 15;
          states = { warning = 25; critical = 10; };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = [ "" "" "" "" "" ];
          tooltip = true;
        };

        "custom/powermenu" = {
          format = "⏻";
          tooltip = "Power Menu";
          on-click = "pkill -f '(^|/)wofi( |$)' || (powermenu & disown)";
        };

        tray = {
          "icon-size" = 16;
          spacing = 6;
        };
      }
    ];
  };
}
