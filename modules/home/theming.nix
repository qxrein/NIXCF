{ config, lib, pkgs, ... }:

with lib;

{
  options.theming = {
    enable = mkEnableOption "enable theming configuration";
    thunar.enable = mkEnableOption "Thunar theming configuration";
  };

  config = mkMerge [
    (mkIf config.theming.enable {
      # Global theming configuration can go here
    })
    
    (mkIf (config.theming.enable && config.theming.thunar.enable) {
      # Thunar-specific configuration
      gtk = {
        enable = true;
        theme = {
          name = "Ayu Dark";
          package = pkgs.artim-dark;
        };
        iconTheme = {
          name = "Colloid icon theme";
          package = pkgs.colloid-icon-theme;
        };
      };
    })
  ];
}
