depName: depConfig:
let
  name = depConfig.name or depName;
  input = atom.registry.combined.${name};
  entryPath = input + "/pkgs/top-level";

  importedPkgs = get.unsafeImport entryPath {
    localSystem = { inherit (atom) system; };
  };

in
assert atom.systemIsDefinedAndEnabled;
importedPkgs
