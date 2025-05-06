{ inputs, pkgs, ... }:

{
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONEE_WL = "1";

  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  environment.systemPackages = with pkgs; [
    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper

    starship
    helix

    mpv
    zathura
    imv
  ];
}
