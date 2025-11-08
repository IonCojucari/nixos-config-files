{
  description = "Ion's multi-host NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager (follows nixpkgs)
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Caelestia Shell and CLI
    caelestia-shell.url = "github:caelestia-dots/shell";
    caelestia-shell.inputs.nixpkgs.follows = "nixpkgs";

    caelestia-cli.url = "github:caelestia-dots/cli";
    caelestia-cli.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, caelestia-shell, caelestia-cli, ... }@inputs:
    let
      system = "x86_64-linux";

      # Helper for defining hosts with Home Manager
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
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";

              # Pass inputs to Home Manager (so we can use inputs.caelestia-shell etc.)
              home-manager.extraSpecialArgs = { inherit inputs; };

              # Import user's Home Manager configuration
              home-manager.users.ion = import homeConfig;
            }
          ];
        };
    in {
      nixosConfigurations = {
        # 🖥️ Desktop
        homepc = mkHost "homepc" {
          configuration = ./hosts/homepc/configuration.nix;
          hardware = ./hosts/homepc/hardware-configuration.nix;
        };

        # 💻 Laptop
        laptop = mkHost "laptop" {
          configuration = ./hosts/laptop/configuration.nix;
          hardware = ./hosts/laptop/hardware-configuration.nix;
        };
      };
    };
}
