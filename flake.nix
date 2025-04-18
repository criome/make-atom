{
  description = "make-atom";

  outputs = inputs: {
    mkAtom = args: import ./default.nix (args // { _calledFromFlake = true; });

    tests = import ./tests.nix;

  };
}
