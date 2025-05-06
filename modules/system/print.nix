{ config, pkgs, lib, ... }:

let
  hplip = pkgs.hplip.override { withPlugin = false; };
in
{
  options.printing = {
    hpSupport = {
      enable = lib.mkEnableOption "HP printer support with HPLIP";
    };
  };

  config = lib.mkIf config.printing.hpSupport.enable {
    environment.systemPackages = with pkgs; [
      hplip
      gutenprint
      cups
      ghostscript
      system-config-printer
    ];

    services.printing = {
      enable = true;
      drivers = with pkgs; [
        hplip
        gutenprint
      ];
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };

    services.udev.packages = [ hplip ];
  };
}
