{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;


  hardware.opengl = {
    # Mesa
    enable = true;
  };

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


  nix.settings.trusted-users = [ "root" "ion" ];

  # Users
  users.users.ion = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
      "render"
      "docker"
    ];
    initialPassword = "changeme";
  };
  security.sudo.enable = true;
  
  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  hardware.graphics = { 
    enable = true;
    enable32Bit = true;
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
