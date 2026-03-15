{
  # Nix configuration
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      http-connections = 10;
      connect-timeout = 60;
      download-buffer-size = 1073741824;
      trusted-users = [ "root" "chikoyeat" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    optimise.automatic = true;
  };
}
