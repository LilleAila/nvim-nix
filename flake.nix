{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";

    # Plugins that are not in nixpkgs
    plugin-img-clip = {
      url = "github:HakonHarnes/img-clip.nvim";
      flake = false;
    };

    plugin-move = {
      url = "github:fedepujol/move.nvim";
      flake = false;
    };
  };

  outputs = {
    nixvim,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = [
        inputs.devshell.flakeModule
      ];

      perSystem = {
        pkgs,
        system,
        ...
      }: let
        nixvimLib = nixvim.lib.${system};
        nixvim' = nixvim.legacyPackages.${system};
        nixvimModule = let
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
          # TODO: Make this an input or override or something, but idk how:
          colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
        in {
          inherit pkgs;
          module = import ./config; # import the module directly
          extraSpecialArgs = {
            inherit mkKeymap mkKeymap' mkKeymapWithOpts;
            inherit colorScheme;
            inherit inputs;
          };
        };
        nvim = nixvim'.makeNixvimWithModule nixvimModule;
      in {
        checks = {
          # Run `nix flake check .` to verify that your config is not broken
          default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
        };

        packages = {
          # Lets you run `nix run .` to start nixvim
          default = nvim;
          nvim = nvim;
        };

        devshells.default = {
          packages = with pkgs; [
            nil
            alejandra
          ];
        };
      };
    };
}
