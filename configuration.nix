{ config, pkgs, pkgs-unstable, quickshell, inputs, lib, ... }:
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
    (import ./modules/packages.nix { inherit quickshell config pkgs pkgs-unstable; }) 
    # (import ./modules/nbfc.nix {inherit config inputs pkgs; }) 
  ];
  
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.8-env"
  ];
  # services.acpid.enable = lib.mkForce false;

  environment.variables = {
    QT_QPA_PLATFORM = "wayland;xcb";
  };
  swapDevices = [
  {
    device = "/swapfile";
  }
];
  services.onlyoffice.enable = true;

  nix.settings = {
    http-connections = 10;
    connect-timeout = 60;
  };
  services.desktopManager.cosmic.enable = true;

  programs.light.enable = true;
  services.thermald.enable = true;
  services.tlp = {
      # enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      };
};

  nix.optimise.automatic = true;
  programs.java = {
    enable = true;
    package = pkgs.openjdk17;  # or pkgs.zulu17 if you prefer Zulu JDK
  };
# services.hardware.openrgb.enable = true;

environment.pathsToLink = [ "/libexec" ];
nix.settings.download-buffer-size = 1073741824;

services.picom.enable = true;
programs.kdeconnect.enable = true;

programs.adb.enable = true;
services.udev.extraRules = let
    idVendor = "0fce";
    idProduct = "320d";
  in ''
    # Allow access to all devices from this vendor
    SUBSYSTEM=="usb", ATTR{idVendor}=="${idVendor}", MODE="0666", GROUP="adbusers", TAG+="uaccess"

    # Create symlink for ADB interface
    SUBSYSTEM=="usb", ATTR{idVendor}=="${idVendor}", ATTR{idProduct}=="${idProduct}", SYMLINK+="android_adb"

    # Create symlink for Fastboot interface
    SUBSYSTEM=="usb", ATTR{idVendor}=="${idVendor}", ATTR{idProduct}=="${idProduct}", SYMLINK+="android_fastboot"
  '';

services.xserver.windowManager.qtile.enable = true;
services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.model = "pc105";
    xkb.options = "eurosign:e, compose:menu, grp:caps_toggle";
    # xrandrHeads = [{output = "HDMI-0";primary = true;}{output = "VGA-0";}];
    xkb.variant = "";
        desktopManager = {
      xterm.enable = false;
      # xfce.enable = true;
    };
    defaultDepth = 24;
      exportConfiguration = true;
      enableTCP = true;
      autorun = true;
    # windowManager.i3 = {
    #   # enable = true;
    #   extraPackages = with pkgs; [
    #     dmenu
    #     i3status
    #     i3lock
    #     i3blocks
    #   ];
    # };
  };  

  # services.displayManager.sddm.enable = true;
  # services.displayManager.gdm.enable = true;
  # services.xserver.displayManager.gdm.wayland = false; # force X11

  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "xfce";

  nix.settings.trusted-users = [ "root" "chikoyeat" ];
  programs.xwayland.enable = true;

  nixpkgs.config.allowUnfree = true;
  
  services.autorandr.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [

    
    "nvidia-drm.modeset=1"
    "intel_pstate=disable"
  ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  
  services.xserver.libinput.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

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
    
    # upower.enable = true;
  };

  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  
  time.timeZone = "Asia/Kolkata";

  hardware = {
    sane.enable = true;
    graphics.enable = true;
    bluetooth.enable = true;
  };

hardware.graphics.extraPackages = [ pkgs.mesa ];
  
  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
  boot.kernelModules = [ "nvidia" "acerhdf" "acer-wmi"  ];
  
 hardware.nvidia = {

    modesetting.enable = true;
    # forceFullCompositionPipeline = true;
    # nvidiaPersistenced = true;
    # powerManagement.enable = true;

    # powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  boot.kernelPackages = pkgs.linuxPackages_6_16;

  hardware.nvidia.prime = {
      # sync.enable = true;
      		# Make sure to use the correct Bus ID values for your system!
  		intelBusId = "PCI:0:2:0";
  		nvidiaBusId = "PCI:01:0:0";
                  # amdgpuBusId = "PCI:54:0:0"; For AMD GPU
	};

  users.users.chikoyeat = {
    isNormalUser = true;
    description = "Manav";
    extraGroups = [ "networkmanager" "wheel" "audio" "adbusers" ];
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
  };

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      Preferences = {
        "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
        "cookiebanners.service.mode" = 2; # Block cookie banners
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
      };
      ExtensionSettings = {
        "jid1-ZAdIEUB7XOzOJw@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  virtualisation.docker.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "*";
  };

  
  i18n.defaultLocale = "en_IN";

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
