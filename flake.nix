{
  description = "make-atom";

  inputs = {
    modified-atom.url = "github:LiGoldragon/atom/atomicFlake-v1";

    atom.url = "github:ekala-project/atom";
    atom.flake = false;
  };

  outputs = inputs: inputs.modified-atom.mkAtomicFlake inputs (./. + "/make-atom@.toml");
}
