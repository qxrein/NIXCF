{ pkgs, lib, ... }:
{
  security.rtkit.enable = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    
    extraConfig.pipewire = {
      "context.properties" = {
        "link.max-buffers" = 16;
        "log.level" = 2;
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 512;
        "default.clock.max-quantum" = 2048;
      };
    };
  };

  services.pipewire.wireplumber.extraConfig = {
    "10-bluez" = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.headset-roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
        "bluez5.codecs" = [ "sbc" "sbc_xq" "aac" "ldac" "aptx" "aptx_hd" "aptx_ll" "faststream" "lc3plus_hr" ];
        "bluez5.default.rate" = 48000;
        "bluez5.default.channels" = 2;
      };
      "monitor.bluez.rules" = [
        {
          matches = [
            { "device.name" = "~bluez_card.*"; }
          ];
          actions = {
            update-props = {
              "bluez5.auto-connect" = [ "a2dp_sink" ];
              "bluez5.hw-volume" = [ "a2dp_sink" ];
              "device.profile" = "a2dp-sink";
            };
          };
        }
      ];
    };
    
    "11-bluetooth-policy" = {
      "wireplumber.settings" = {
        "bluetooth.autoswitch-to-headset-profile" = false;
      };
    };
    
    "12-bluez-codec-priority" = {
      "monitor.bluez.properties" = {
        "bluez5.enable-ldac" = true;
        "bluez5.enable-aac" = true;
      };
    };
    
    # AUTO-SWITCH TO BLUETOOTH WHEN CONNECTED
    "50-auto-default-bluetooth" = {
      "monitor.bluez.rules" = [
        {
          matches = [
            { "node.name" = "~bluez_output.*"; }
          ];
          actions = {
            update-props = {
              # High priority makes Bluetooth the default when connected
              "priority.session" = 2000;
              "node.pause-on-idle" = false;
            };
          };
        }
      ];
    };
  };

  services.pulseaudio.enable = false;
  
  environment.systemPackages = with pkgs; [
    pamixer
    pavucontrol
    wireplumber
    pipewire
  ];
  
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
}
