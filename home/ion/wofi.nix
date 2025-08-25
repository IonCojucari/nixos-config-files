{ config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;

    settings = {
      # Behavior
      show = "drun";
      prompt = "Search…";
      normal_window = true;
      width = 640;
      height = 420;
      location = "center";
      allow_images = true;
      allow_markup = true;
      insensitive = true;
      matching = "fuzzy";
      "dpi-aware" = "yes";
      hide_scroll = true;
      no_actions = false;
      show_all = false;
      sort_order = "alphabetical";
      columns = 1;
      lines = 8;
      key_expand = "Tab";
      key_exit = "Escape";
    };

    style = ''
      window {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 12pt;
        background-color: rgba(0,0,0,0.9); /* Black with slight transparency */
        color: #ffffff; /* White text */
        border: 2px solid #ffffff;
        border-radius: 10px;
        padding: 8px;
      }
      #input {
        margin: 8px;
        padding: 8px 10px;
        border-radius: 6px;
        border: 1px solid #666666; /* Gray border */
        background-color: #111111;
        color: #ffffff;
      }
      #inner-box {
        margin: 6px 8px 8px 8px;
        border-radius: 8px;
        background-color: #0d0d0d;
      }
      #entry {
        padding: 8px 10px;
        margin: 3px 6px;
        border-radius: 6px;
        color: #ffffff;
      }
      #entry:selected {
        background-color: #cccccc; /* Softer gray highlight */
        color: #000000;            /* Black text on highlight */
      }
      #img { margin-right: 10px; }
    '';
  };
}
