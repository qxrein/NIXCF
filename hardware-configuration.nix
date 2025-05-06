{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "vmd" "ahci" "nvme" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    
    # Recommended for NVMe drives
    kernelParams = [ "nvme_core.default_ps_max_latency_us=0" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/345f67a8-bb3a-4d84-bb96-4d453539e069";
      fsType = "ext4";
      options = [ "noatime" "discard" ]; # SSD optimizations
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/11E7-14CF";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };

  swapDevices = [ ];

  # Enable power management (adjust for your hardware)
  powerManagement.enable = true;

  # CPU microcode updates
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Enable sound (if needed)
  services.pipewire.enable = lib.mkDefault true;

  # Network configuration
  networking = {
    useDHCP = lib.mkDefault true;
    # Uncomment and adjust if using static IP
    # interfaces.enp2s0.ipv4.addresses = [ {
    #   address = "192.168.1.100";
    #   prefixLength = 24;
    # } ];
    # defaultGateway = "192.168.1.1";
    # nameservers = [ "8.8.8.8" "8.8.4.4" ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
