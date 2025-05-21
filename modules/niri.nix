{ inputs, pkgs, ... }:

{
  environment.sessionVariables.NIXOS_OZONEE_WL = "1";
  programs.niri.enable = true;
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  environment.systemPackages = with pkgs; [
    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper

    starship
    wayland
    xwayland-satellite
    rofi-wayland
    helix

    mpv
    zathura
    imv
  ];
}

