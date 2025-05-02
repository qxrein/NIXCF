{ config, pkgs, pkgs-unstable, ghostty, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import ./modules/packages.nix { inherit config pkgs pkgs-unstable ghostty; })
    ];

   nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.8-env"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      glibc
      zlib
      # Add other required libraries here
    ];
  };


    boot.kernelParams = [ "intel_pstate=disable" ]; # only if you're using Intel
    services.udev.extraRules = ''
      SUBSYSTEM=="cpu", KERNEL=="cpu[0-9]*", ATTR{scaling_governor}="performance"
    '';

  
  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
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

  nixpkgs.config.allowBroken = true;

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    
    desktopManager.xterm.enable = false;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };
  };  



services.displayManager.defaultSession = "none+i3";
  services.upower.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;  # Uncomment if you want to use JACK applications
  };

  # Syncthing configuration
  services.syncthing = {
    enable = true;
    user = "chikoyeat";
    dataDir = "/home/chikoyeat/Documents";
    configDir = "/home/chikoyeat/Documents/.config/syncthing";
  };

  
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };  

  xdg.portal.config.common.default = "*";

  # Enable Flatpak
  services.flatpak.enable = true;

  # Define user account
  users.users.chikoyeat = {
    isNormalUser = true;
    description = "Manav";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.nushell;
  };

  # Enable Firefox
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Enable Thunar file manager
  programs.thunar.enable = true;
  programs.dconf.enable = true;

  virtualisation.docker.enable = true;

  hardware.bluetooth = {
    enable = true;
  };

  system.stateVersion = "24.05"; 
  fonts = {
	    packages = with pkgs; [
	      ibm-plex
        sarasa-gothic
	      material-design-icons
	      noto-fonts-cjk-sans
        dejavu_fonts
	      iosevka  # Use the installed package
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


  ## nvidia
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  	hardware.nvidia.prime = {
      		offload = {
    			enable = true;
    			enableOffloadCmd = true;
		};
  		# Make sure to use the correct Bus ID values for your system!
  		intelBusId = "PCI:0:2:0";
  		nvidiaBusId = "PCI:01:0:0";
                  # amdgpuBusId = "PCI:54:0:0"; For AMD GPU
	};
}
  
  
