let
  inherit (std) hasAttr;

  matchManifestFile = string: std.match "(^.*@\.toml)" string;

  mkMatchCandidate =
    name: value:
    let
      isFile = value == "regular";
      matchResult = matchManifestFile name;
      isSingleMatch = (std.length matchResult) == 1;
    in
    isFile && (matchResult != null) && isSingleMatch;

  candidateIndex = std.mapAttrs mkMatchCandidate (std.readDir atom.root);

  mkCandidateName = name: candidateIndex.${name};

  candidates = std.filter mkCandidateName (std.attrNames candidateIndex);

  mkFilterCandidate =
    fileName:
    let
      data = get.core.readToml "${atom.root}/${fileName}";
      hasIdAndVersion = hasAttr "id" data.atom && hasAttr "version" data.atom;
      looksLikeManifest = hasAttr "atom" data && hasIdAndVersion;
    in
    if looksLikeManifest then [ data ] else [ ];

  manifests = std.concatMap mkFilterCandidate candidates;

  hasSingleManifest = (std.length manifests) == 1;

  firstManifest = std.head manifests;

  firstManifestWithWarning = std.warn ''
    Warning: Source seems to hold multiple atom manifests:
      Using manifest for `${firstManifest.data.atom.id}`
      Source is: ${atom.root}
  '' firstManifest;

in
if hasSingleManifest then firstManifest else firstManifestWithWarning
