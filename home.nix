{ config, lib, pkgs, ... }:
{
  home.username = "chikoyeat";
  home.homeDirectory = "/home/chikoyeat";
  home.stateVersion = "24.05";
  
  # Add packages directly
  home.packages = with pkgs; [
    # Base Thunar packages
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    hyprpanel
    waybar
    
    # Add any other packages you need
    gnome-themes-extra  # Fixed: gnome.gnome-themes-extra -> gnome-themes-extra
  ];

  # Basic environment variables
  home.sessionVariables = {
    EDITOR = "hx";
  };
  
  # Basic theming configuration
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;  # Fixed: gnome.gnome-themes-extra -> gnome-themes-extra
    };
  };
  
  # Enable Home Manager
  programs.home-manager.enable = true;
  
  # Note: We're not using programs.thunar here as it's causing issues
  # Instead, we installed the thunar packages directly above
}
