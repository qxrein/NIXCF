{ config, lib, pkgs, ... }:

{
  # Boot configuration
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelModules = [ "nvidia" "acerhdf" "acer-wmi" ];
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "nvidia-drm.modeset=1"
      "intel_pstate=disable"
    ];
  };

  # Hardware configuration
  hardware = {
    # Graphics
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        mesa
        libva
        libva-utils
      ];
    };

    # NVIDIA configuration
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      # Prime offloading
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:01:0:0";
      };
    };

    # Other hardware
    sane.enable = true;
    bluetooth.enable = true;
  };

  # X server video drivers
  services.xserver.videoDrivers = [ "nvidia" ];
}
