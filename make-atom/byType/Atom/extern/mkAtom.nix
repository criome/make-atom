inputName: inputConfig:
let
  inherit (pre) inputs;
  inherit (atom) system config;

  name = inputConfig.name or inputName;
  type = inputConfig.type or "atom";
  src = if type == "local" then root else inputs.${name};

  # TODO this will obviously evolve
  manifestFileName = "${name}@.toml";
  manifest = "${src}/${manifestFileName}";

  overrides = inputConfig.inputOverrides or [ ];
  depHasInputOverrides = overrides != [ ];
  overrideInputs = builtins.getAttrs overrides inputs;
  optionalOverrides = if depHasInputOverrides then overrideInputs else { };
  optionalInputs = if propagate then inputs else optionalOverrides;

  args = {
    atomSrc = src;
    inputs = optionalInputs;
  };

in
get.mkAtom { inherit args system; }
