depName: depConfig:
let
  name = depConfig.name or depName;
  src = atom.registry.combined.${name};
  extern = mod.value;
  subdir = depConfig.subdir or null;
  hasSubdir = subdir != null;
  pathToImport = src + lib.optionalString hasSubdir "/${subdir}";
  depArgs = depConfig.args or [ ];
  hasArgs = depArgs != [ ];

  applyNextArg =
    appliedFunction: nextArgument:
    let
      argsFromDeps = depConfig.argsFromDeps or true && builtins.isAttrs nextArgument;
      intersectedArgument = nextArgument // (builtins.intersectAttrs nextArgument extern);
    in
    if argsFromDeps then appliedFunction intersectedArgument else appliedFunction nextArgument;

  importedSrcWithArgs = builtins.foldl' applyNextArg (import pathToImport) depArgs;

in
if hasArgs then importedSrcWithArgs else get.unsafeImport pathToImport
