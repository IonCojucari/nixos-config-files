{
  description = "Ion's multi-host NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix/release-26.05";
  };

  outputs = { nixpkgs, home-manager, catppuccin, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      users = {
        ion = {
          hosts = [ "homepc" "laptop" ];
          nixos = ./users/ion/nixos.nix;
          home = ./users/ion/home;
          session = {
            name = "niri";
            type = "wayland";
          };
        };
        assma = {
          hosts = [ "homepc" "laptop" ];
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
        let
          enabledUsers = lib.filterAttrs (
            _: spec:
            !(spec ? hosts) || lib.elem hostName spec.hosts
          ) users;
        in
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit hostName inputs;
            userSpecs = enabledUsers;
          };
          modules =
            modules
            ++ lib.mapAttrsToList (_: spec: spec.nixos) enabledUsers
            ++ [
              ./modules/services/login/user-sessions.nix
              home-manager.nixosModules.home-manager

              {
                networking.hostName = hostName;

                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "backup";
                home-manager.sharedModules = [
                  ./modules/home/browser-defaults.nix
                  ./modules/home/session-launchers.nix
                ];
                home-manager.extraSpecialArgs = {
                  inherit hostName inputs;
                  userSpecs = enabledUsers;
                };
                home-manager.users = lib.mapAttrs (_: spec: import spec.home) enabledUsers;
              }
            ];
        };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          git
          nixd
          nixfmt
        ];
      };

      formatter.${system} = pkgs.nixfmt;

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
