{
  description = "MineSSDM - A Minecraft-styled SDDM theme";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.default = pkgs.stdenv.mkDerivation {
        pname = "sddm-theme-minesddm";
        version = "1.0.0";
        src = ./.;

        installPhase = ''
          mkdir -p $out/share/sddm/themes/minesddm
          cp -r minesddm/* $out/share/sddm/themes/minesddm/
        '';

        meta = with pkgs.lib; {
          description = "A Minecraft-styled SDDM theme";
          license = licenses.gpl3;
          platforms = platforms.linux;
        };
      };
    }) // {
      nixosModules.default = { pkgs, ... }: {
        environment.systemPackages = [
          self.packages.${pkgs.system}.default
        ];
      };
    };
}