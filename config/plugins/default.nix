{...}: {
  imports = [
    ./ui
    ./lsp
    ./utils
    ./org
    ./obsidian
  ];

  extraConfigLuaPre =
    /*
    lua
    */
    ''
      vim.loader.enable() -- Enable experimental lua loader: https://neovim.io/doc/user/lua.html#vim.loader
    '';
}
