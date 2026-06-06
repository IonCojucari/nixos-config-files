{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard
    fastfetch
    vulkan-tools
    nvtopPackages.amd
    cava
    texlive.combined.scheme-full
    tectonic
  ];
}
