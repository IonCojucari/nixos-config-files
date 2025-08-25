{ lib, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      # General
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";

      # Font (use any Nerd Font you installed)
      font_family = "JetBrainsMono Nerd Font";
      font_size = 13;

      # Transparency & padding
      window_padding_width = 8;
      background_opacity = "0.6"; 

      # Black & White Theme
      foreground = "#ffffff"; # white text
      background = "#000000"; # black background

      # Grayscale palette
      color0  = "#000000"; # black
      color7  = "#aaaaaa"; # mid gray
      color15 = "#ffffff"; # white

      # Optional: make all bright colors shades of gray too
      color1  = "#555555"; # dark gray
      color2  = "#777777";
      color3  = "#999999";
      color4  = "#bbbbbb";
      color5  = "#dddddd";
      color6  = "#eeeeee";
      color8  = "#444444";
      color9  = "#666666";
      color10 = "#888888";
      color11 = "#aaaaaa";
      color12 = "#cccccc";
      color13 = "#e0e0e0";
      color14 = "#f5f5f5";
    };
  };
}
