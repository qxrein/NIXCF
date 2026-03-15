{ lib, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    allowInsecure = true;
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "CiscoPacketTracer"
        "nvidia-x11"
      ];

    permittedInsecurePackages = [
      "ciscoPacketTracer8-8.2.2"
    ];

  };
}
