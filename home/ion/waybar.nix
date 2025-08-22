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
        border: none;
        text-shadow: none;
        transition: none;
        box-shadow: none;
      }

      window#waybar {
        background: none;   /* bar background transparent */
        color: #ffffff;     /* default text white */
        margin: 40px 15px 0px 15px;  /* push bar 40px down, add side margins */
      }

      window#waybar.hidden { opacity: 1; }

      /* Each module → black rounded rectangle */
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
      #group-media,
      #custom-powermenu {
        font-family: JetBrainsMono Nerd Font;
        font-size: 14px;
        font-weight: bold;
        background: #000000;   /* black module background */
        color: #ffffff;        /* white text */
        margin: 0 6px;
        padding: 4px 8px;
        border-radius: 6px;    /* rounded corners */
      }

      #cava {
        font-size: 14px;
        padding: 0 6px;
      }

      #mpris {
        font-size: 14px;
        padding: 0 6px;
      }

      #group-media {
        background: #000000;
        padding: 0 6px;
        margin: 0;
        border-radius: 6px;
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
        background: #000000;
        border: 2px solid #000000;
      }

      #workspaces button:hover   { border-color: #ffffff; background: #000000; }
      #workspaces button.active  { background: #ffffff; border-color: #ffffff; }
      #workspaces button.urgent  { background: red; border-color: red; }

      #tray {
        padding: 0 6px;
      }

      #custom-powermenu {
        font-size: 14px;
      }

      #custom-powermenu:hover {
        color: #ff0000;
      }
    '';

    settings = [
      {
        layer = "top";
        position = "top";
    	margin-top = 10; 
    	margin-left = 5;
    	margin-right = 5;

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
          "group/media"                # unified cava + mpris
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
