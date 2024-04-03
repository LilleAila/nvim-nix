{
  pkgs,
  colorScheme,
  ...
}: {
  imports = [
    ./ui
    ./lsp
    ./utils
    ./org
  ];

  extraPlugins = [
    {
      plugin = import ./colorscheme.nix {inherit pkgs;} {scheme = colorScheme;};
      config = "colorscheme nix-${colorScheme.slug}";
    }
  ];

  extraConfigLuaPre =
    /*
    lua
    */
    ''
      vim.loader.enable() -- Enable experimental lua loader: https://neovim.io/doc/user/lua.html#vim.loader
    '';
}
