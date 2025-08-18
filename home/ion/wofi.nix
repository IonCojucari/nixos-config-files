{ config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    # optionally pin a fork/build:
    # package = pkgs.wofi;

    settings = {
      # --- behavior ---
      show = "drun";                 # default mode
      prompt = "Search…";
      normal_window = true;          # not fullscreen
      width = 640;
      height = 420;
      location = "center";
      allow_images = true;
      allow_markup = true;
      insensitive = true;            # case-insensitive
      matching = "fuzzy";
      "dpi-aware" = "yes";           # hyphenated keys must be quoted
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
      /* theme aligned with your Waybar palette */
      window {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 12pt;
        background-color: rgba(30,30,42,0.96);
        color: #d9e0ee;
        border: 2px solid #33ccff;
        border-radius: 12px;
        padding: 8px;
      }
      #input {
        margin: 8px;
        padding: 8px 10px;
        border-radius: 8px;
        border: 1px solid #414868;
        background-color: #1e1e2a;
        color: #d9e0ee;
      }
      #inner-box {
        margin: 6px 8px 8px 8px;
        border-radius: 10px;
        background-color: #181825;
      }
      #entry {
        padding: 8px 10px;
        margin: 3px 6px;
        border-radius: 8px;
        color: #d9e0ee;
      }
      #entry:selected {
        background-color: #f8bd96;  /* orange highlight */
        color: #1a1826;
      }
      #img { margin-right: 10px; }
    '';
  };

  #  ensure fonts/helpers are present
  home.packages = with pkgs; [
    jetbrains-mono
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    wl-clipboard
  ];
}
