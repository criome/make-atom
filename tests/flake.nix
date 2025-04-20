{
  description = "mkAtom tests";

  inputs = {
    devenv-atom.url = "github:criome/devenv-atom/testing";
    rust-atom.url = "github:criome/rust-atom/testing";
    horizons-rs.url = "github:criome/horizons-rs";
    horizons-rs.flake = false;
  };

  outputs =
    inputs:
    let
      bootstrap = import ../bootstrap/mkLib.nix { };
      inherit (bootstrap) mkAtom;

      simpleRustDevenvAtom = mkAtom {
        system = "x86_64-linux";
        args = {
          atomName = "devenv-atom";
          atomSrc = inputs.devenv-atom;
          inputs.config = {
            atomSrc = inputs.rust-atom;
            inputs.src = {
              src = inputs.horizons-rs;
            };
          };
        };
      };

    in
    {
      atom = simpleRustDevenvAtom;
    };
}
