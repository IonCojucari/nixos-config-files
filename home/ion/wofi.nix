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
        color: #c8c8cc;                /* muted grey text */
        background: transparent;
      }

      #window {
        background: rgba(25, 18, 38, 0.96);  /* near-black violet */
        margin: auto;
        padding: 10px;
        border-radius: 20px;
        border: 2px solid #4a3c63;          /* subtle dark violet border */
      }

      #input {
        padding: 10px;
        margin-bottom: 10px;
        border-radius: 15px;
        background-color: rgba(35, 25, 50, 0.95);  /* dark violet input */
        color: #e0e0e3;
        border: 1px solid #5a4b73;
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
        background-color: rgba(60, 45, 80, 0.85);  /* deeper selection violet */
        border: 1px solid #7a68a0;
      }

      #text {
        margin: 2px;
      }
    '';
  };
}
