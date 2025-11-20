{
  description = "Ion's multi-host NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager (follows nixpkgs)
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
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
