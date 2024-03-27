{
  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        libraries = with pkgs; [ bun ];

        packages = with pkgs; [ bun ];
      in {
        devShell = pkgs.mkShell {
          buildInputs = packages;

          shellHook = ''
            git config user.name Twiggeh
            git config user.email twiggeh99@gmail.com
            export LD_LIBRARY_PATH=${
              pkgs.lib.makeLibraryPath libraries
            }:$LD_LIBRARY_PATH
          '';
        };
      });
}

