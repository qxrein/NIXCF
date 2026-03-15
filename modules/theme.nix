{ lib, pkgs, pkgs-unstable ? pkgs, themes, ... }:

let
  inherit (lib) mkOption types;
  baseTheme = themes.raw.ayu-dark;
in
{
  options = {
    theme = mkOption {
      type = types.attrs;
      default = themes.custom (baseTheme // {
        cornerRadius = 4;
        borderWidth = 2;

        margin = 0;
        padding = 8;

        font = {
          size = {
            normal = 16;
            big = 20;
          };
          sans = {
            name = "Lexend";
            package = pkgs.lexend;
          };
          mono = {
            name = "JetBrainsMono Nerd Font";
            package = pkgs.nerd-fonts.jetbrains-mono;
          };
        };

        icons = {
          name = "dracula-icon-theme";
          package = pkgs.dracula-icon-theme;
        };
      });
      description = "Theme configuration";
    };
  };

  config = {
    gtk = {
      enable = true;

      theme = {
        name = "Ayu Dark";
        package = pkgs.artim-dark;
      };

      iconTheme = {
        name = "Colloid";
        package = pkgs.colloid-icon-theme;
      };
    };
  };
}
