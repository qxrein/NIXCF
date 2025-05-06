{ config, pkgs, ... }:
let
  modules = import ./modules { inherit pkgs; };
in {
  imports = [
    ./hardware-configuration.nix
    ./modules/apps/thorium
    modules.system.print
    modules.system.networking
    modules.display.manager
    modules.development.lsp
    modules.common.jujutsu
    modules.common.theme
    (import ./modules/packages.nix { inherit config pkgs; }) 
  ];
  
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.8-env"
  ];
  
  nixpkgs.config.allowUnfree = true;
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "intel_pstate=disable" ];
  
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  
  services.xserver.libinput.enable = true;

  apps.thorium.enable = true;
  
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  services = {
    udev.extraRules = ''
      SUBSYSTEM=="cpu", KERNEL=="cpu[0-9]*", ATTR{scaling_governor}="performance"
    '';
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
    flatpak.enable = true;
    syncthing = {
      enable = true;
      user = "chikoyeat";
      dataDir = "/home/chikoyeat/Documents";
      configDir = "/home/chikoyeat/Documents/.config/syncthing";
    };
    # Enable thunar services at system level
    gvfs.enable = true;  # For trash and mounting functionality
    tumbler.enable = true;  # For thumbnails
    
    # Audio config is fully handled in modules.system.sound

    upower.enable = true;
  };


    services.xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";

    };

  security.rtkit.enable = true;
  
  time.timeZone = "Asia/Kolkata";

  hardware = {
    sane.enable = true;
    bluetooth.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:01:0:0";
      };
    };
  };
  
  users.users.chikoyeat = {
    isNormalUser = true;
    description = "Manav";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    shell = pkgs.nushell;
  };
  
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    jujutsu.enable = true;
    thunar.enable = true;
    dconf.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [ glibc zlib ];
    };
    firefox.enable = true;
  };
  virtualisation.docker.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "*";
  };

  
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  fonts = {
    packages = with pkgs; [
      ibm-plex
      sarasa-gothic
      material-design-icons
      noto-fonts-cjk-sans
      dejavu_fonts
      iosevka
    ];
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Sarasa Gothic" ];
        sansSerif = [ "IBM Plex Sans" ];
        serif = [ "IBM Plex Serif" ];
      };
    };
  };
  system.stateVersion = "24.05";
}
