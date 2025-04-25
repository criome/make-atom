{
  description = "mkAtom";

  inputs = {
    atom.url = "github:LiGoldragon/atom/testing";
    lib.url = "github:nix-community/nixpkgs.lib";
    flake-compat.url = "github:edolstra/flake-compat";
  };

  outputs =
    inputs:
    let
      bootstrap = import ./bootstrap/mkLib.nix {
        inherit (inputs.lib) lib;
        atomCore = inputs.atom.core;
        flake-compat = import inputs.flake-compat;
      };

      defaultMkAtom = bootstrap.mkAtom;

    in
    {
      mkAtom = args: defaultMkAtom (args // { _calledFromFlake = true; });

      mkAtomFlake =
        atomSrc: inputs:
        defaultMkAtom {
          args = { inherit atomSrc; };
          system = inputs.system.value;
          _calledFromFlake = true;
          registry = removeAttrs inputs [
            "self"
            "system"
            "make-atom"
          ];
        };

      tests = import ./tests.nix;
    };
}
