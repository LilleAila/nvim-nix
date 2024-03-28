{...}: {
  imports = [
    ./oil.nix
    ./sessions.nix
    ./telescope.nix
  ];

  plugins = {
    luasnip.enable = true;
    nvim-autopairs.enable = true;
    comment-nvim.enable = true;
    direnv.enable = true;
  };
}
