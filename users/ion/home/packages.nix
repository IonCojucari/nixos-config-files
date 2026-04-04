{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard

    fastfetch
    vulkan-tools
    nvtopPackages.amd
    pulseaudio
    cava
    texlive.combined.scheme-full
    tectonic
  ];
}
