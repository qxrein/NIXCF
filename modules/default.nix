{ pkgs, ... }:
{
  system = {
    print = import ./system/print.nix;
    networking = import ./system/networking.nix;
    sound = import ./system/sound.nix;
  };

  display = {
    manager = import ./display-manager.nix;
  };

  development = {
    lsp = import ./development/lsp.nix;
  };

  common = {
    jujutsu = import ./common/jujutsu.nix;
    theme = import ./common/theme.nix;
  };
}
