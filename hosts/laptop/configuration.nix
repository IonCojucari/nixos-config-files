{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports = [
    ./hardware-configuration.nix
    ../../modules/services/login/gdm.nix
    ../../modules/programs/common.nix
    ../../modules/programs/gaming.nix
    ../../modules/desktop/plumbing.nix
    ../../modules/desktop/fonts.nix
    ../../modules/programs/xmrig.nix
  ];

  time.timeZone = "Europe/Paris";
  networking.networkmanager.enable = true;
  virtualisation.docker = {
    enable = true;
  };

  # Users
  users.users.ion = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
      "docker"
    ];
    initialPassword = "changeme";
  };
  security.sudo.enable = true;
  
  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
  # Battery power
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;


  hardware.graphics = { 
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      rocmPackages.clr
    ];
  };

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Microcode updates
  hardware.cpu.amd.updateMicrocode = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.05";
}
