{
  description = "qxrein's nixos config";
  
  nixConfig = {
    extra-experimental-features = "nix-command flakes pipe-operators";
  };
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixgl.url = "github:nix-community/nixGL";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    ghostty.url = "github:ghostty-org/ghostty";
    ags.url = "github:Aylur/ags";
  };
  
  outputs = { self, nixpkgs,nixgl, nixpkgs-unstable,quickshell, hyprpanel, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          nixgl.overlay
         ];
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs pkgs quickshell pkgs-unstable;
        };
       modules = [
          ./configuration.nix
          ./modules/niri.nix
          ./modules/hyprland.nix
          ./modules/apps/thorium

          inputs.home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.chikoyeat = {
              imports = [ ./home.nix ];
            };
          }
        ];
      };
      
    };
}
