{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.programs.jujutsu;
in {
  options.programs.jujutsu = {
    enable = mkEnableOption "Jujutsu version control system";
    
    settings = mkOption {
      type = types.attrs;
      default = {};
      description = "Jujutsu configuration settings";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      jujutsu
      difftastic
    ];

    programs.jujutsu.settings = cfg.settings // {
      user = {
        name = "qxrein";
        email = "manavrj.07@gmail.com";
      };
      ui = {
        default-command = "status";
        diff.tool = "${pkgs.difftastic}/bin/difft --color always";
      };
    };
  };
}
