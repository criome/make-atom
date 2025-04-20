atomSrc: inputs:

(import ./mkLib.nix).mkAtom {
  args = { inherit atomSrc; };

  system = inputs.system.value;

  _calledFromFlake = true;

  local-registry = (
    removeAttrs inputs [
      "self"
      "system"
      "make-atom"
    ]
  );
}
