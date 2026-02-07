{ pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.virt-manager.enable = true;
  services.udev.packages = with pkgs; [
    trezor-udev-rules
  ];
  services.trezord.enable = true;

  environment.systemPackages = with pkgs; [
    btop-rocm
    brave
    bisq2
    blender
    cloudcompare
    curl
    discord
    devenv
    dynamips
    exodus
    feather
    gcc
    gns3-gui
    gns3-server
    git
    gnumake
    hyprshot
    inetutils
    kooha
    lact
    libvirt
    dotnet-sdk_8
    nvme-cli
    openssl
    pavucontrol
    pkg-config
    qbittorrent
    rocmPackages.rocm-smi
    telegram-desktop
    tor-browser
    tree
    trezor-suite
    ubridge
    unzip
    vpcs
    vlc
    xmrig
    zip
    (vscode-extensions.ms-dotnettools.csharp)
    (python3.withPackages (ps: with ps; [
      bleach
      flask
      flask-cors
      flask-limiter
      fpdf
      numpy
      pandas
      pypdf2
      gunicorn
      python-dotenv
      ps.google-genai
      requests
    ]))
  ];
}
