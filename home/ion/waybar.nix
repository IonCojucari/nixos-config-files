{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ pamixer ];

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    systemd.enable = false;

    style = ''
      /* ================================ */
      /*   Invisible Rectangles, Black Text */
      /* ================================ */

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
        background: none;    /* bar fully transparent */
        color: #000000;      /* default text black */
        margin-top: 15px;    /* still aligned top */
        margin-left: 15px;
        margin-right: 15px;
      }

      window#waybar.hidden { opacity: 1; }

      /* ================================ */
      /*     Generic module appearance    */
      /* ================================ */
      #custom-launcher,
      #window,
      #tray,
      #cpu,
      #temperature,
      #backlight,
      #memory,
      #custom-cava-internal,
      #network,
      #pulseaudio,
      #pulseaudio.muted,
      #battery,
      #battery.critical,
      #battery.warning,
      #clock,
      #group-sound-bright-network,
      #group-sys-stats {
        font-family: JetBrainsMono Nerd Font;
        font-size: 18px;
        font-weight: bold;
        background: none;   /* fully invisible modules */
        border: none;
        margin: 0 6px;
        padding: 0 4px;
        color: #000000;     /* force black text/icons */
      }

      /* ================================ */
      /*            Workspaces            */
      /* ================================ */
      #workspaces {
        padding: 0 2px;
        background: transparent;
      }

      #workspaces button {
        font-size: 0;
        min-width: 20px;       /* force button width */
        min-height: 20px;      /* force button height */
        padding: 0;
        margin: 0 6px;
        border-radius: 3px;    /* square with slight rounding */
        background: transparent;
        border: 2px solid #000000; /* black outline */
      }

      #workspaces button:hover   { border-color: #000000; background: #000000; }
      #workspaces button.active  { background: #000000; border-color: #000000; }
      #workspaces button.urgent  { background: #000000; border-color: #000000; }

      /* ================================ */
      /*            Tray                  */
      /* ================================ */
      #tray { padding: 0 6px; }

      /* ================================ */
      /*         Custom Powermenu         */
      /* ================================ */
      #custom-powermenu {
        background: transparent;
        border: none;
        color: #000000;    /* black glyph */
        font-size: 26px;
        padding: 0 8px;
      }

      #custom-powermenu:hover {
        color: #000000;    /* stays black on hover */
      }

      /* ================================ */
      /*       All module colors black    */
      /* ================================ */
      #cpu,
      #temperature,
      #memory,
      #backlight,
      #pulseaudio,
      #pulseaudio.muted,
      #network,
      #battery,
      #battery.warning,
      #battery.critical,
      #clock {
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
          "custom/cava-internal"
        ];

        modules-center = [
          "clock"
          "tray"
        ];

        modules-right = [
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

        "custom/cava-internal" = {
          exec = "sleep 1s && cava-internal";
          tooltip = false;
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
          format = "{:%I:%M %p}";
          tooltip = true;
          tooltip-format = "{=%A; %d %B %Y}\n<tt>{calendar}</tt>";
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
