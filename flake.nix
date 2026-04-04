{
  description = "Ion's multi-host NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      users = {
        ion = {
          nixos = ./users/ion/nixos.nix;
          home = ./users/ion/home;
        };
      };

      mkHost = {
        hostName,
        modules,
      }:
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit hostName inputs;
          };
          modules =
            modules
            ++ lib.mapAttrsToList (_: spec: spec.nixos) users
            ++ [
              home-manager.nixosModules.home-manager

              {
                networking.hostName = hostName;

                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "backup";
                home-manager.extraSpecialArgs = {
                  inherit hostName inputs;
                };
                home-manager.users = lib.mapAttrs (_: spec: import spec.home) users;
              }
            ];
        };
    in {
      nixosConfigurations = {
        homepc = mkHost {
          hostName = "homepc";
          modules = [
            ./hosts/homepc/configuration.nix
          ];
        };

        laptop = mkHost {
          hostName = "laptop";
          modules = [
            ./hosts/laptop/configuration.nix
          ];
        };
      };
    };
}
