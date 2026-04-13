{
  description = "dotfiles — NixOS + home-manager configuration";

  inputs = {
    nixpkgs.url   = "github:nixos/nixpkgs/nixos-unstable";
    home-manager  = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    stylix.url    = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }:
  let
    system = "x86_64-linux";

    homeFor = file: { config, ... }: {
      home-manager.useGlobalPkgs    = true;
      home-manager.useUserPackages  = true;
      home-manager.extraSpecialArgs = { inherit (config.dotfiles) username gitName gitEmail; };
      home-manager.users.${config.dotfiles.username} = import file;
    };

    shared = [
      stylix.nixosModules.stylix
      ./modules/params.nix
      ./modules/system/base.nix
      ./modules/system/theme.nix
      ./modules/system/security.nix
      ./modules/system/networking.nix
      ./modules/system/services.nix
      home-manager.nixosModules.home-manager
    ];

    mkHost = modules: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = shared ++ modules;
    };
  in
  {
    nixosConfigurations = {

      # ── default — Hyprland desktop ───────────────────────────────────────────
      # 1. Edit hosts/default/params.nix with your username, hostname, GPU info
      # 2. Provide hosts/default/hardware-configuration.nix (nixos-generate-config)
      # 3. sudo nixos-rebuild switch --flake .#default
      default = mkHost [
        (homeFor ./home/default.nix)
        ./hosts/default/params.nix
        ./hosts/default
      ];

    };
  };
}
