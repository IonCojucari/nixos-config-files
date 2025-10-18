{
  description = "Ion's multi-host NixOS configuration";

  inputs = {
    # Use NixOS 25.05
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Home Manager matching the same release
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      # Small helper to avoid repeating Home Manager setup
      mkHost = hostName: {
        configuration,
        hardware,
        homeConfig ? ./home/ion/default.nix
      }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            configuration
            hardware
            home-manager.nixosModules.home-manager
            {
              home-manager.users.ion = import homeConfig;
              home-manager.backupFileExtension = "backup";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
    in {
      nixosConfigurations = {
        # 🖥️ Home PC configuration
        homepc = mkHost "homepc" {
          configuration = ./hosts/homepc/configuration.nix;
          hardware = ./hosts/homepc/hardware-configuration.nix;
        };

        # 💻 Laptop configuration
        laptop = mkHost "laptop" {
          configuration = ./hosts/laptop/configuration.nix;
          hardware = ./hosts/laptop/hardware-configuration.nix;
        };
      };
    };
}
