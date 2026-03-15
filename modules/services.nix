{ pkgs, lib, ... }:

let
  idVendor = "0fce";
  idProduct = "320d";
in
{
  # Desktop managers
  services.desktopManager = {
    cosmic.enable = true;
  };

  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];

  # System services
  services = {
    # Network services
    avahi = {
      enable = true;
      nssmdns4 = true;
    };

    # Storage and sync
    flatpak.enable = true;
    syncthing = {
      enable = true;
      user = "chikoyeat";
      dataDir = "/home/chikoyeat/Documents";
      configDir = "/home/chikoyeat/Documents/.config/syncthing";
    };

    # Desktop services
    gvfs.enable = true;
    tumbler.enable = true;

    # Applications
    # onlyoffice.enable = true;

    # Power management
    power-profiles-daemon.enable = false;
    # thermald.enable = true;
    auto-cpufreq.enable = true;
    auto-cpufreq.settings = {
      battery = {
         governor = "powersave";
         turbo = "never";
      };
      charger = {
         governor = "performance";
         turbo = "auto";
      };
    };
   
    # Display server
    xserver = {
      enable = true;
      # windowManager.qtile.enable = true;
      xkb = {
        layout = "us";
        model = "pc105";
        variant = "";
        options = "eurosign:e, compose:menu, grp:caps_toggle";
      };
      defaultDepth = 24;
      exportConfiguration = true;
      enableTCP = true;
      autorun = true;
      desktopManager = {
        xterm.enable = false;
      };
    };

    # Input
    libinput.enable = true;

    # Printing
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };

    # Audio
    pulseaudio.enable = false;

    # Compositor
    picom.enable = true;

    # Display management
    autorandr.enable = true;

    # USB/ADB rules
    udev.extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="${idVendor}", MODE="0666", GROUP="adbusers", TAG+="uaccess"
      SUBSYSTEM=="usb", ATTR{idVendor}=="${idVendor}", ATTR{idProduct}=="${idProduct}", SYMLINK+="android_adb"
      SUBSYSTEM=="usb", ATTR{idVendor}=="${idVendor}", ATTR{idProduct}=="${idProduct}", SYMLINK+="android_fastboot"
    '';
  };

  # Security
  security.rtkit.enable = true;

  # Virtualization
  virtualisation.docker.enable = true;
}
