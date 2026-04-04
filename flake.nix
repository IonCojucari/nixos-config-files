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
          session = {
            name = "hyprland";
            type = "wayland";
          };
        };
        assma = {
          nixos = ./users/assma/nixos.nix;
          home = ./users/assma/home;
          session = {
            name = "plasma";
            type = "wayland";
          };
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
            userSpecs = users;
          };
          modules =
            modules
            ++ lib.mapAttrsToList (_: spec: spec.nixos) users
            ++ [
              ./modules/services/login/user-sessions.nix
              home-manager.nixosModules.home-manager

              {
                networking.hostName = hostName;

                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "backup";
                home-manager.extraSpecialArgs = {
                  inherit hostName inputs;
                  userSpecs = users;
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
