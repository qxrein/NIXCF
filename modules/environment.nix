{ pkgs, ... }:

{
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_DESKTOP = "niri";
  GBM_BACKEND = "nvidia-drm";
  __GL_GSYNC_ALLOWED = "0";
  __GL_VRR_ALLOWED = "0";
  __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # Environment variables
  environment = {
    variables = {
      QT_QPA_PLATFORM = "wayland;xcb";
      NIXOS_OZONE_WL = "1";
      # NVIDIA-specific variables
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    pathsToLink = [ "/libexec" ];

    shells = with pkgs; [ nushell ];
  };

  # Internationalization
  i18n.defaultLocale = "en_IN";
  time.timeZone = "Asia/Kolkata";

  # Fonts
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

  # XDG portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "*";
  };
}
