{
  config,
  inputs,
  pkgs,
  ...
}: let
  myUser = "chikoyeat"; 
  command = "bin/nbfc_service --config-file '/home/${myUser}/.config/nbfc.json'";
in {
  environment.systemPackages = with pkgs; [
    # if you are on stable uncomment the next line
    # inputs.nbfc-linux.packages.x86_64-linux.default
    # if you are on unstable uncomment the next line
    nbfc-linux
  ];
  systemd.services.nbfc_service = {
    # enable = true;
    description = "NoteBook FanControl service";
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.kmod ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.nbfc-linux}/${command}";
    };
  };

}
