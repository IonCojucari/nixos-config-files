{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (_final: prev: {
      pkgsi686Linux = prev.pkgsi686Linux.extend (_final32: prev32: {
        # OpenLDAP's i686 syncrepl test is flaky and blocks Lutris/Bottles FHS builds.
        openldap = prev32.openldap.overrideAttrs (_old: {
          doCheck = false;
        });
      });
    })
  ];

  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true; 
  };

  programs.gamemode.enable = true;
  programs.gamescope.capSysNice = true;

  programs.steam = {
    enable = true;
    extest.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    gamescopeSession = {
      enable = true;
      args = [
        "--rt"
        "--adaptive-sync"
      ];
      env = {
        ENABLE_GAMESCOPE_WSI = "1";
        PROTON_USE_NTSYNC = "1";
        STEAM_MULTIPLE_XWAYLANDS = "1";
      };
    };
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    osu-lazer
    mangohud
    bottles
    lumafly
    winetricks
    vulkan-tools

    (lutris.override {
      extraPkgs = pkgs: [
        winetricks
        wineWow64Packages.staging
        vulkan-tools
        gnutls
        libnet
      ];
    })
  ];
}
