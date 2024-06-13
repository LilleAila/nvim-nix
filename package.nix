{
  pkgs,
  nixvim,
  colorScheme,
  inputs,
  ...
}: let
  nixvim' = nixvim.legacyPackages.${pkgs.system};
  nixvimModule = {
    inherit pkgs;
    module = import ./config; # import the module directly
    extraSpecialArgs =
      {
        inherit colorScheme;
        inherit inputs;
      }
      // import ./lib;
  };
in
  nixvim'.makeNixvimWithModule nixvimModule
