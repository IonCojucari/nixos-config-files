{ pkgs, ... }:

let
  powermenuBin = pkgs.writeShellScriptBin "powermenu" ''
    #!/usr/bin/env bash
    choice=$(printf "%s\n" \
      " Poweroff" \
      " Reboot" \
      " Lock" \
      " Suspend" \
      "󰍃 Logout" \
      | wofi --dmenu --prompt "Power Menu" --hide-scroll --insensitive)

    case "$choice" in
      " Poweroff")  systemctl poweroff ;;
      " Reboot")    systemctl reboot ;;
      " Lock")
        if command -v hyprlock >/dev/null 2>&1; then
          hyprlock
        elif command -v swaylock >/dev/null 2>&1; then
          swaylock -f -c 000000
        else
          notify-send "No locker" "Install hyprlock or swaylock"
        fi
        ;;
      " Suspend")   systemctl suspend ;;
      "󰍃 Logout")    hyprctl dispatch exit ;;
      *) exit 0 ;;
    esac
  '';
in
{
  # Install dependencies and script in PATH
  home.packages = with pkgs; [
    hyprlock
    powermenuBin
  ];
}
