{ ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";

      font_family = "Maple Mono NF CN";
      font_size = 13;

      window_padding_width = 8;
      background_opacity = "0.93";
      background_blur = 1;
    };
  };
}
