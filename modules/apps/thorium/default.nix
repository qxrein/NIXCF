{ lib, pkgs, config, ... }:

with lib;

let
  cfg = config.apps.thorium;
  thoriumPkg = pkgs.callPackage ./package.nix {};
in {
  options.apps.thorium = {
    enable = mkEnableOption "Thorium browser";
    
    package = mkOption {
      type = types.package;
      default = thoriumPkg;
      defaultText = "pkgs.callPackage ./package.nix {}";
      description = "Thorium package to use";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
