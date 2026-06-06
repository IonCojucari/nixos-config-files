{ inputs, lib, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  # catppuccin/nix unconditionally declares programs.<editor>.profiles for a
  # fixed list of editors, several of which (cursor, windsurf, kiro,
  # antigravity) have no home-manager module. Declare freeform stubs so the
  # assignments evaluate cleanly.
  options.programs = lib.genAttrs [ "antigravity" "cursor" "windsurf" "kiro" "vscodium" ] (_: lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
    default = { };
    visible = false;
    description = "Stub to absorb catppuccin/nix's unconditional assignment.";
  });

  config = {
    # https://github.com/catppuccin/nix
    catppuccin = {
      enable = true;
      flavor = "mocha";
      accent = "pink";
    };
  };
}
