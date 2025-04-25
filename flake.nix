{
  description = "mkAtom";

  inputs = {
    atom.url = "github:LiGoldragon/atom/testing";
    lib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-compat.url = "github:edolstra/flake-compat";
  };

  outputs =
    inputs:
    let
      bootstrap = import ./bootstrap/mkLib.nix {
        inherit (inputs.lib) lib;
        atomCore = inputs.atom.core;
        flake-compat = import inputs.flake-compat;
        nixpkgsFn = import (inputs.nixpkgs + "/pkgs/top-level");
      };

      defaultMkAtom = bootstrap.mkAtom;

    in
    {
      mkAtom = args: defaultMkAtom (args // { _calledFromFlake = true; });

      mkAtomFlake =
        atomSrc: flakeInputs:
        defaultMkAtom {
          args = { inherit atomSrc; };
          system = flakeInputs.system.value;
          _calledFromFlake = true;
          registry = removeAttrs flakeInputs [
            "self"
            "system"
            "make-atom"
          ];
        };

      tests = import ./tests.nix;
    };
}
