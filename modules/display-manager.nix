{ pkgs, ... }:  # Only declare what you need
{
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland";
      user = "greeter";
    };
  };
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
    i3
  ];
}
