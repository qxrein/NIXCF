{ config, pkgs, lib, ... }:

let
  # Use standard hplip without plugin (we'll handle plugin separately)
  hplip = pkgs.hplip.override { withPlugin = false; };
in
{
  options.printing = {
    hpSupport = {
      enable = lib.mkEnableOption "HP printer support with HPLIP";
    };
  };

  config = lib.mkIf config.printing.hpSupport.enable {
    # Required system packages (minimal set)
    environment.systemPackages = with pkgs; [
      hplip
      gutenprint
      cups
      ghostscript
      system-config-printer
    ];

    # Printing services
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        hplip
        gutenprint
      ];
    };

    # CUPS configuration
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };

    # Fix permissions for USB devices
    services.udev.packages = [ hplip ];
  };
}
