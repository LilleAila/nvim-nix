{
  pkgs,
  colorScheme,
  lib,
  ...
}: {
  imports = [
    ./ui
    ./lsp
    ./utils
  ];

  extraPlugins = [
    {
      plugin = import ./colorscheme.nix {inherit pkgs;} {scheme = colorScheme;};
      config = "colorscheme nix-${colorScheme.slug}";
    }
  ];

  # This works, but telescope looks VERY weird :(
  # colorschemes.base16 = {
  # 	enable = true;
  # 	colorscheme = lib.concatMapAttrs (name: value: {
  # 			${name} = "#${value}";
  # 		}) colorScheme.palette;
  # };

  # Other plugins
  plugins = {
    luasnip.enable = true;
    nvim-autopairs.enable = true;
    comment-nvim.enable = true;
    rainbow-delimiters.enable = true;
    direnv.enable = true;
  };
}
