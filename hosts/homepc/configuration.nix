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
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.runAsRoot = false;
  };

  nix.settings.trusted-users = [ "root" "ion" ];

  # group required for ubridge wrapper
  users.groups.ubridge = { };

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
      "libvirtd"
      "kvm"
      "ubridge"   # added here
    ];
    initialPassword = "changeme";
  };

  # create ubridge wrapper with capabilities
  security.wrappers.ubridge = {
    owner = "root";
    group = "ubridge";
    source = "${pkgs.ubridge}/bin/ubridge";
    permissions = "u+rx,g+rx,o+rx";
    capabilities = "cap_net_admin,cap_net_raw=ep";
  };

  security.sudo.enable = true;
  security.polkit.enable = true;
  
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

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  hardware.cpu.amd.updateMicrocode = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "kvm-amd" ];

  system.stateVersion = "25.05";
}
