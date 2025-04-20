{
  AtomName = "devenv-atom";

  AtomSrc = mod.srcs.devenv-atom;

  Inputs.config = {
    atomSrc = mod.srcs.rust-atom;

    inputs.src = {
      src = mod.srcs.horizons-rs;
    };
  };
}
