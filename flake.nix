{
		description = "A nixvim configuration";

		inputs = {
			nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

			nixvim.url = "github:nix-community/nixvim";
			nixvim.inputs.nixpkgs.follows = "nixpkgs";

			flake-parts.url = "github:hercules-ci/flake-parts";

			nix-colors.url = "github:misterio77/nix-colors";
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

			perSystem = {
				pkgs,
				system,
				...
			}: let
				nixvimLib = nixvim.lib.${system};
				nixvim' = nixvim.legacyPackages.${system};
				nixvimModule = let
					mkKeymap = mode: key: action: {
						inherit mode key action;
						options = {
							silent = true;
						};
					};
					mkKeymapWithOpts = mode: key: action: options: { inherit mode key action options; };
					colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
					nix-colors-lib = inputs.nix-colors.lib.contrib { inherit pkgs; };
					colorSchemePlugin = {
						plugin = nix-colors-lib.vimThemeFromScheme { scheme = colorScheme; };
						config = "colorscheme nix-${colorScheme.slug}";
					};
				in {
					inherit pkgs;
					module = import ./config; # import the module directly
					extraSpecialArgs = {
						inherit mkKeymap mkKeymapWithOpts colorSchemePlugin;
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
				};
			};
		};
}
