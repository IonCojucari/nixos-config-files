{ pkgs, ... }:
{
  imports = [
    ../services/login/gdm.nix
    ../programs/common.nix
    ../programs/xmrig.nix
    ../desktop/plumbing.nix
    ../desktop/fonts.nix
    ../desktop/plasma.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  time.timeZone = "Europe/Paris";
  networking.networkmanager.enable = true;

  virtualisation.docker.enable = true;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16384;
    }
  ];

  security.sudo.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      rocmPackages.clr
    ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
