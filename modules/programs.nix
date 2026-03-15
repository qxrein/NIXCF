{ config, pkgs, pkgs-unstable, ... }:

{
  programs = {
    # Development tools
    java = {
      enable = true;
      package = pkgs.openjdk17;
    };

    # Desktop environment
    light.enable = true;
    kdeconnect.enable = true;
    jujutsu.enable = true;
    thunar.enable = true;
    dconf.enable = true;
    xwayland.enable = true;

    # Nix compatibility
    nix-ld = {
      enable = true;
      libraries = with pkgs; [ glibc zlib ];
    };

    # Browser
    firefox = {
      enable = true;
      # package = pkgs.librewolf;
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        Preferences = {
          "cookiebanners.service.mode.privateBrowsing" = 2;
          "cookiebanners.service.mode" = 2;
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

  #   # Gaming
  #   steam = {
  #     enable = true;
  #     remotePlay.openFirewall = true;
  #     dedicatedServer.openFirewall = true;
  #   };
  };
}
