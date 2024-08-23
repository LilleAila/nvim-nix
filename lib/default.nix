rec {
  mkKeymap = mode: key: action: desc: {
    inherit mode key action;
    options = {
      inherit desc;
      silent = true;
      noremap = true;
    };
  };
  # Make keymap without description:
  mkKeymap' =
    mode: key: action:
    mkKeymap mode key action null;
  mkKeymapWithOpts = mode: key: action: options: {
    inherit
      mode
      key
      action
      options
      ;
  };
  mkRegistration = __unkeyed-1: desc: { inherit __unkeyed-1 desc; };
}
