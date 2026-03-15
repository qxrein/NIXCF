{ pkgs, ... }:

{
  users.users.chikoyeat = {
    isNormalUser = true;
    description = "Manav";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "adbusers"
    ];
    shell = pkgs.nushell;
  };
}
