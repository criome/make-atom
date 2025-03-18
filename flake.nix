{
  description = "make-atom";

  outputs = inputs: {
    mkAtom = import ./default.nix;
    tests = import ./tests.nix;
  };
}
