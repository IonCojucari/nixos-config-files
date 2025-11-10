{ config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;

    settings = {
      hide_scroll = true;
      show = "drun";
      width = "30%";
      lines = 8;
      line_wrap = "word";
      term = "kitty";
      allow_markup = true;
      always_parse_args = false;
      show_all = true;
      print_command = true;
      layer = "overlay";
      allow_images = true;
      sort_order = "alphabetical";
      gtk_dark = true;
      prompt = "";
      image_size = 20;
      display_generic = false;
      location = "center";
      key_expand = "Tab";
      insensitive = false;
    };

    style = ''
      * {
        font-family: "JetBrainsMono";
        color: #d0d0d5;                /* soft light grey text */
        background: transparent;
      }

      #window {
        background: rgba(28, 27, 34, 0.96);   /* deep grey with subtle violet tone */
        margin: auto;
        padding: 10px;
        border-radius: 20px;
        border: 2px solid #3d3950;           /* muted grey-violet border */
      }

      #input {
        padding: 10px;
        margin-bottom: 10px;
        border-radius: 15px;
        background-color: rgba(36, 34, 44, 0.95);  /* dark grey input */
        color: #e4e4e8;
        border: 1px solid #514b63;                /* soft violet tint */
      }

      #outer-box {
        padding: 20px;
      }

      #img {
        margin-right: 6px;
      }

      #entry {
        padding: 10px;
        border-radius: 12px;
        background-color: transparent;
        transition: background-color 0.15s ease-in-out;
      }

      #entry:selected {
        background-color: rgba(60, 55, 75, 0.9);  /* darker violet-grey selection */
        border: 1px solid #6a6080;
      }

      #text {
        margin: 2px;
      }
    '';
  };
}
