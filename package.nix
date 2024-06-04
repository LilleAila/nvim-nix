{
  pkgs,
  nixvim,
  colorScheme,
  inputs,
  ...
}: let
  nixvim' = nixvim.legacyPackages.${pkgs.system};
  nixvimModule = let
    # Lib functions, TODO: move to separate lib/ directory?
    mkKeymap = mode: key: action: desc: {
      inherit mode key action;
      options = {
        inherit desc;
        silent = true;
        noremap = true;
      };
    };
    # Make keymap without description:
    mkKeymap' = mode: key: action: mkKeymap mode key action null;
    mkKeymapWithOpts = mode: key: action: options: {inherit mode key action options;};
  in {
    inherit pkgs;
    module = import ./config; # import the module directly
    extraSpecialArgs = {
      inherit mkKeymap mkKeymap' mkKeymapWithOpts;
      inherit colorScheme;
      inherit inputs;
    };
  };
in
  nixvim'.makeNixvimWithModule nixvimModule
