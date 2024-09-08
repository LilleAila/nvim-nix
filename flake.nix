{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

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

    plugin-org-bullets = {
      url = "github:nvim-orgmode/org-bullets.nvim";
      flake = false;
    };

    plugin-cmp-vimtex = {
      url = "github:micangl/cmp-vimtex";
      flake = false;
    };

    plugin-cmp-nerdfont = {
      url = "github:chrisgrieser/cmp-nerdfont";
      flake = false;
    };

    # plugin-texmagic = {
    #   url = "github:jakewvincent/texmagic.nvim";
    #   flake = false;
    # };

    # plugin-hologram = {
    #   url = "github:edluffy/hologram.nvim";
    #   flake = false;
    # };

    plugin-obsidian-bridge = {
      url = "github:oflisback/obsidian-bridge.nvim";
      flake = false;
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      pkgsFor = lib.genAttrs systems (system: import nixpkgs { inherit system; });
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    in
    {
      packages = forEachSystem (pkgs: rec {
        default = pkgs.callPackage ./package.nix {
          inherit inputs;
          colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
        };
        nvim = default;
        nixvim = default;
      });

      devShells = forEachSystem (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nixfmt-rfc-style
            nixd
            statix
          ];
        };
      });
    };
}
