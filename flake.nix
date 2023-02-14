{
  description = "A simple development environment for Idris 2";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    idris2-lsp = {
      url = "github:idris-community/idris2-lsp/idris2-0.6.0";
      flake = false;
    };
  };

  outputs = { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      perSystem = { pkgs, ... }:
        let
          idris2 = pkgs.callPackage ./packages/idris2-with-api.nix {};

          idris2-lsp = pkgs.callPackage ./packages/idris2-lsp.nix {
            idris2-with-api = idris2;
            src = inputs.idris2-lsp;
          };

          vscodium-idris2 = pkgs.vscode-with-extensions.override {
            vscode = pkgs.vscodium;
            vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
              {
                name = "idris2-lsp";
                publisher = "bamboo";
                version = "0.7.0";
                sha256 = "sha256-8eLvHKUPBoge50wzOfp5aK/XVJElVzKtil8Yj+PwNUU=";
              }
            ];
          };
        in
        {
          devShells = rec {
            default = pkgs.mkShell {
              buildInputs = [
                idris2
                idris2-lsp
              ];
            };

            with-vscodium = default.overrideAttrs (oldAttrs: {
              buildInputs = oldAttrs.buildInputs ++ [ vscodium-idris2 ];
            });
          };

          packages = {
            inherit idris2 idris2-lsp;
          };
        };

      flake = {
        templates.default = {
          path = ./template;
          description = "Idris project template";
        };
      };
    };
}
