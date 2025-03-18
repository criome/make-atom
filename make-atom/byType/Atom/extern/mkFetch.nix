inputName: inputConfig:
let
  type = inputConfig.type or "atom";
  typeError = abort "Dependency `${inputName}` declares type `${type}` which does not exist";

  makeIndex = {
    atom = mod.mkAtom;
    flake = mod.mkFlake;
    import = mod.mkImport;
    lib = mod.mkImport;
    local = mod.mkAtom;
    pkgs = mod.mkPkgs;
    src = mod.mkSrc;
  };

  makerFn = makeIndex.${type} or typeError;

in
makerFn inputName inputConfig
