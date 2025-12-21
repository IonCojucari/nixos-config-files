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
    git
    gcc
    tree
    zip
    btop-rocm
    curl
    gnumake
    nvme-cli
    unzip
    pkg-config
    vlc
    openssl
    devenv
    rocmPackages.rocm-smi
    lact
    pavucontrol
    telegram-desktop
    tor-browser
    blender
    cloudcompare
    kooha
    qbittorrent
    discord
    hyprshot
    gns3-gui
    gns3-server
    dynamips
    vpcs
    ubridge
    inetutils
    brave
    trezor-suite
    exodus
    feather
    libvirt
    dotnet-sdk_8
    bisq2
    xmrig
    (vscode-extensions.ms-dotnettools.csharp)
    (python3.withPackages (ps: with ps; [
      numpy
      pandas
      requests
      flask
      flask-cors
      flask-limiter
      pypdf2
      fpdf
      bleach
      gunicorn
      python-dotenv
      ps.google-genai
      bleach      
    ]))
  ];

}
