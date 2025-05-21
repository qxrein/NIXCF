{ pkgs, lib, ... }:

{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  
  # Disable pulseaudio if it's enabled
  services.pulseaudio.enable = false;

      environment.systemPackages = with pkgs; [
    pamixer
    pavucontrol
  ];
}
