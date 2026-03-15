{
  description = "qxrein's nixos config";
  
  nixConfig = {
    extra-experimental-features = "nix-command flakes pipe-operators";
  };
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixgl.url = "github:nix-community/nixGL";
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
     antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.antigravity-nix.url = "github:jacopone/antigravity-nix/v1.11.5-5234145629700096";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";  # Use same quickshell version
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    # ghostty.url = "github:ghostty-org/ghostty";
    # ags.url = "github:Aylur/ags";
  };
  
  outputs = { self, nixpkgs, nixgl, nur, nixpkgs-unstable, quickshell, noctalia, hyprpanel, antigravity-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      
      # Base nixpkgs with overlays for unstable packages
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
          permittedInsecurePackages = [
              "ciscoPacketTracer8-8.2.2"
          ];
        };
        overlays = [
          (final: prev: {
            rabbitmq-server = prev.rabbitmq-server.overrideAttrs (old: {
              doInstallCheck = false;
            });
          })
          nixgl.overlay
        ];
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs nur quickshell pkgs-unstable antigravity-nix;
        };
        modules = [
          {
            environment.systemPackages = [
              antigravity-nix.packages.x86_64-linux.default
            ];
          }
          # Base configuration
          ./configuration.nix
          
          # Nixpkgs configuration module
          ./modules/nixpkgs.nix
          ./modules/nix.nix
          ./modules/networking.nix
          ./modules/environment.nix
          ./modules/users.nix
          ./modules/programs.nix
          ./modules/hardware.nix
          ./modules/services.nix
          
          # Window managers and compositors
          ./modules/niri.nix
          ./modules/hyprland.nix
          ./noctalia.nix
          # Applications
          ./modules/apps/thorium

          # inputs.home-manager.nixosModules.home-manager
          # {
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;

          #   home-manager.users.chikoyeat = {
          #     imports = [ ./home.nix ];
          #   };
          # }
        ];
      };
    };
}
