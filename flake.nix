{
  description = "chikoyeat's NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    themes = {
      url = "github:RGBCube/ThemeNix";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager,ghostty, themes, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        overlays = [
        inputs.hyprpanel.overlay
	  ];
      };
      theme = themes.tango;
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgs-unstable ghostty; };
          modules = [
            ./configuration.nix
            ./modules/hyprland.nix
            ./modules/sound.nix
            ./modules/networking.nix
            ./modules/lsp.nix
            {nixpkgs.overlays = [inputs.hyprpanel.overlay];}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.chikoyeat = import ./home.nix;
              home-manager.extraSpecialArgs = {
                inherit inputs pkgs-unstable;
              };
            }
          ];
        };
        mysystem = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ ... }: {
            _module.args.ghostty = ghostty;
          })
              ./configuration.nix
          {
            home-manager.users.myuser = {
              programs.kitty.settings = with theme.withHashtag; {
                color0  = base00;
                color1  = base08;
                color2  = base0B;
                color3  = base0A;
                color4  = base0D;
                color5  = base0E;
                color6  = base0C;
                color7  = base05;
                color8  = base03;
                color9  = base08;
                color10 = base0B;
                color11 = base0A;
                color12 = base0D;
                color13 = base0E;
                color14 = base0C;
                color15 = base07;
                color16 = base09;
                color17 = base0F;
                color18 = base01;
                color19 = base02;
                color20 = base04;
                color21 = base06;
              };

              # Using templates??? Wow, that's so cool!
              programs.bat = {
                config.theme = "base16";
                themes.base16.src = pkgs.writeText "base16.tmTheme" theme.tmTheme;
              };
            };
          }
            ];
          };
      };

        homeConfigurations = {
          "chikoyeat@nixos" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
              inherit inputs pkgs-unstable;
            };
            modules = [ ./home.nix ];
          };
        };
      };
}
