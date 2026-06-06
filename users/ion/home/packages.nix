{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard
    fastfetch
    nwg-displays
    vulkan-tools
    nvtopPackages.amd
    cava
    texlive.combined.scheme-full
    tectonic
  ];
}
