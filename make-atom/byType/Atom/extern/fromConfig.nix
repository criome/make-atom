let
  mkInputIsDisabled =
    inputName:
    let
      optional = atom.config.fetch.${inputName}.optional or false;
      featureIsEnabled = builtins.elem inputName pre.features;
    in
    optional && !(featureIsEnabled);

  disabledNames = std.filter mkInputIsDisabled (std.attrNames atom.config.fetch);

  explicitNames = std.attrNames mod.fromArgs;

  inputsToBeFetched = removeAttrs atom.config.fetch (disabledNames ++ explicitNames);

in
std.mapAttrs mod.mkFetch inputsToBeFetched
