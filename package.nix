{
  pkgs,
  system,
  colorScheme,
  inputs,
  ...
}:
inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
  inherit pkgs;
  module = import ./config; # The actual configuration
  extraSpecialArgs = {
    inherit colorScheme inputs;
  } // import ./lib; # Util functions such as mkKeymap
}
