{
  description = "mkAtom";

  outputs = inputs: {
    mkAtom = args: import ./default.nix (args // { _calledFromFlake = true; });

    mkAtomFlake = import ./bootstrap/mkAtomFlake.nix;

    tests = import ./tests.nix;

  };
}
