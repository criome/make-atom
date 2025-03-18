let
  inherit (std) hasAttr;

  hasAtomSrc = std.hasAttr "atomSrc" get.args;

  numberOfAttrs = std.length (std.attrNames get.args);
  hasSingleAttr = 1 == numberOfAttrs;
  hasTwoAttrs = 2 == numberOfAttrs;
  hasTwoOrThreeAttrs = hasTwoAttrs || numberOfAttrs == 3;

  looksLikeAtom = hasTwoOrThreeAttrs && hasAtomSrc;

  looksLikeSource = hasSingleAttr && hasAttr "src" get.args;

in
if looksLikeAtom then
  "atom"
else if looksLikeSource then
  "source"
else
  "unknown"
