{
  # Human-readable description of the flake
  description = "Go development environment";

  # Flake inputs (other flakes/packages we depend on)
  inputs = {
    # Nixpkgs provides the package set (go, gopls, etc.)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Utility helpers for writing flakes (e.g. eachDefaultSystem)
    flake-utils.url = "github:numtide/flake-utils";
  };

  # The outputs function receives the resolved inputs; we pattern-match the inputs we need
  outputs = { self, nixpkgs, flake-utils }:
    # Produce outputs for each default system (x86_64-linux, aarch64-linux, ...)
    flake-utils.lib.eachDefaultSystem (system:
      let
        # pkgs is the package set for the chosen system (e.g. x86_64-linux)
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # Define a default development shell; `nix develop` will use this by default
        devShells.default = pkgs.mkShell {
          # Tools made available inside the dev shell
          buildInputs = with pkgs; [
            go          # Go toolchain
            gopls       # Go language server (IDE/editor integration)
            delve       # Go debugger
            golangci-lint # Aggregated linter for Go
          ];

          # Project-local GOPATH (useful for GOPATH-mode workflows or local installs).
          # Note: if your project uses Go modules (go.mod), GOPATH is usually not required.
          GOPATH = "${toString ./.}/.go";

          # Commands executed each time you enter the dev shell
          shellHook = ''
            # Export the same project-local GOPATH into the interactive shell
            export GOPATH="${toString ./.}/.go"
            # Where `go install` will put binaries for convenience
            export GOBIN="$GOPATH/bin"
            # Ensure binaries installed to GOBIN are on PATH
            export PATH="$GOBIN:$PATH"
            # Create common GOPATH directories if missing
            mkdir -p $GOPATH/{bin,src,pkg}

            # Friendly confirmation message when the shell starts
            echo "🐹 Go dev environment ready!"
          '';
        };
      }
    );
}