{ config, pkgs, pkgs-unstable, quickshell, inputs, nur, lib, ... }:
let
  modules = import ./modules { inherit pkgs; };
in {
  imports = [
    ./hardware-configuration.nix
    # ./qtile.nix
    modules.system.print
    modules.system.networking
    modules.display.manager
    modules.development.lsp
    modules.common.jujutsu
    modules.common.theme
    (import ./modules/system/sound.nix { inherit lib pkgs; })
    (import ./modules/packages.nix { inherit quickshell config pkgs pkgs-unstable nur; }) 
    # (import ./modules/nbfc.nix {inherit config inputs pkgs; }) 
  ];
  
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.8-env"
  ];
  
  swapDevices = [
    {
      device = "/swapfile";
    }
  ];

  programs.kdeconnect.enable = true;
  
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 30;
  };

  services.printing.browsing = false;
  
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
   "CiscoPacketTracer"
 ];
  
  # Ensure boot loader is properly configured (hardware.nix sets systemd-boot)
  boot.loader.grub.enable = false;
  
  # System state version
  system.stateVersion = "24.05";
}
