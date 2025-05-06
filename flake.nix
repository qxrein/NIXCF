{
  description = "qxrein's nixos config";
  
  nixConfig = {
    extra-experimental-features = "nix-command flakes pipe-operators";
    extra-substituters = "https://cache.nixos.org";
  };
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    ghostty.url = "github:ghostty-org/ghostty";
  };
  
  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.hyprpanel.overlay
        ];
       };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs pkgs pkgs-unstable; };  # Now passing both pkgs
        modules = [
          ./configuration.nix
          ./modules/hyprland.nix
          {nixpkgs.overlays = [inputs.hyprpanel.overlay];}
        ];
      };
    };
}
