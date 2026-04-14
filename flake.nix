{
  description = "nixeko — NixOS + home-manager";

  inputs = {
    nixpkgs.url      = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url       = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }:
  let
    # ── Edit these before installing ────────────────────────────────────────────
    username    = "eko";
    hostname    = "nixos";
    gitName     = "eko";
    gitEmail    = "alexanderkoydl@outlook.com";
    hasNvidia   = true;
    intelBusId  = "PCI:0:2:0";  # lspci | grep -E "VGA|3D" → convert 00:02.0 to PCI:0:2:0
    nvidiaBusId = "PCI:1:0:0";
    # ────────────────────────────────────────────────────────────────────────────

    system = "x86_64-linux";
    args   = { inherit username hostname gitName gitEmail hasNvidia intelBusId nvidiaBusId; };
  in
  {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = args;
      modules = [
        stylix.nixosModules.stylix
        ./modules/system/base.nix
        ./modules/system/security.nix
        ./modules/system/networking.nix
        ./modules/system/services.nix
        ./modules/system/nvidia.nix
        ./modules/system/theme.nix
        ./hosts/default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs    = true;
          home-manager.useUserPackages  = true;
          home-manager.extraSpecialArgs = args;
          home-manager.users.${username} = import ./home;
        }
      ];
    };
  };
}
