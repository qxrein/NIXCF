{ config, pkgs, lib, ... }:

{
  home.username = "chikoyeat";
  home.homeDirectory = "/home/chikoyeat";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    waybar
    gnome-themes-extra
  ];

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri"; 
    EDITOR = "hx";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  programs.home-manager.enable = true;
}
