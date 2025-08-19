{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git
    curl
    nvme-cli
    unzip
    fastfetch
    vulkan-tools
    nvtopPackages.amd
    btop
  ];
}
