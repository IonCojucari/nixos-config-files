{ pkgs, ... }:
{
  home.packages = with pkgs; [ rofi ];

  xdg.configFile."rofi/theme.rasi".text = ''
    * {
        bg-col: #1D2021;
        bg-col-light: #282828;
        border-col: #A89984;
        selected-col: #3C3836;
        green: #98971A;
        fg-col: #FBF1C7;
        fg-col2: #EBDBB2;
        grey: #BDAE93;
        highlight: @green;
    }
  '';

  xdg.configFile."rofi/config.rasi".text = ''
    configuration{
          modi: "run,drun,window";
          lines: 5;
          cycle: false;
          font: "JetBrainsMono Nerd Font Bold 16";
          show-icons: true;
          icon-theme: "Adwaita";
          terminal: "kitty";
          drun-display-format: "{icon} {name}";
          location: 0;
          disable-history: true;
          hide-scrollbar: true;
          display-drun: " Apps ";
          display-run: " Run ";
          display-window: " Window ";
          sidebar-mode: true;
          sorting-method: "fzf";
        }

        @theme "theme"

        element-text, element-icon , mode-switcher {
          background-color: inherit;
          text-color:       inherit;
        }

        window {
          height: 530px;
          width: 400px;
          border: 2px;
          border-color: @border-col;
          background-color: @bg-col;
        }

        mainbox {
          background-color: @bg-col;
        }

        inputbar {
          children: [prompt,entry];
          background-color: @bg-col-light;
          border-radius: 5px;
          padding: 0px;
        }

        prompt {
          background-color: @green;
          padding: 4px;
          text-color: @bg-col-light;
          border-radius: 3px;
          margin: 10px 0px 10px 10px;
        }

        textbox-prompt-colon {
          expand: false;
          str: ":";
        }

        entry {
          padding: 6px;
          margin: 10px 10px 10px 5px;
          text-color: @fg-col;
          background-color: @bg-col;
          border-radius: 3px;
        }

        listview {
          border: 0px 0px 0px;
          padding: 6px 0px 0px;
          margin: 10px 0px 0px 6px;
          columns: 1;
          background-color: @bg-col;
          cycle: true;
        }

        element {
          padding: 8px;
          margin: 0px 10px 4px 4px;
          background-color: @bg-col;
          text-color: @fg-col;
        }

        element-icon {
          size: 28px;
        }

        element selected {
          background-color:  @selected-col ;
          text-color: @fg-col2  ;
          border-radius: 3px;
        }

        mode-switcher {
          spacing: 0;
        }

        button {
          padding: 10px;
          background-color: @bg-col-light;
          text-color: @grey;
          vertical-align: 0.5;
          horizontal-align: 0.5;
        }

        button selected {
          background-color: @bg-col;
          text-color: @green;
        }
  '';

  xdg.configFile."rofi/powermenu-theme.rasi".text = ''
    @theme "theme"

    configuration {
        show-icons: false;
        font: "JetBrainsMono Nerd Font Bold 22";
    }

    window {
        width:                       500px;
        location:                    center;
        anchor:                      center;

        margin:                      0px;
        padding:                     0px;
        
        border:                      2px solid;
        border-radius:               0px;
        border-color:                @border-col;
        
        background-color:            @bg-col;
    }

    mainbox {
        enabled:                     true;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @selected-col;
        background-color:            inherit;
        children:                    [ "listview" ];
    }

    listview {
        enabled:                     true;
        lines:                       1;
        columns:                     5;
        cycle:                       true;
        dynamic:                     true;
        scrollbar:                   false;
        layout:                      vertical;
        reverse:                     false;
        fixed-height:                true;
        fixed-columns:               true;
        spacing:                     0px;
        border:                      inherit;
        border-radius:               inherit;
        border-color:                inherit;
        text-color:                  @fg-col;
        background-color:            transparent;
    }

    element {
        enabled:                     true;
        spacing:                     0px;
        padding:                     28px 0px;
        border:                      inherit;
        border-radius:               inherit;
        border-color:                inherit;
        background-color:            inherit;
        text-color:                  @fg-col;
        cursor:                      pointer;
    }

    element-text {
        vertical-align:              0.5;
        horizontal-align:            0.5;
        font:                        inherit;
        text-color:                  inherit;
        background-color:            transparent;
        cursor:                      inherit;
    }

    element selected.normal {
        background-color:            @selected-col;
    }
  '';
}
