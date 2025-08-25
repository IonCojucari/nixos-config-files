{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Clipboard and screenshots
    wl-clipboard
    grim
    slurp

    # Audio utilities
    pavucontrol

    # Monitoring and tools
    fastfetch
    vulkan-tools
    nvtopPackages.amd
    btop
    pkgs.tree
    pkgs.trezor-suite
    pkgs.pulseaudio

    pamixer
    cava
    hyprpaper
    pkgs.texlive.combined.scheme-full
    tectonic

    #temporary 
    pkgs.google-chrome
  ];
}
