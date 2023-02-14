{
  inputs = {
    nix-idris.url = "github:CS-222-Idris2/nix-idris";
    flake-parts.follows = "nix-idris/flake-parts";
  };

  outputs = { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      perSystem = { pkgs, ... }: {
        devShells = inputs.nix-idris.devShells;
      };
    };
}
