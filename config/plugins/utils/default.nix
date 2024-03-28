{...}: {
  imports = [
    ./oil.nix
    ./sessions.nix
    ./telescope.nix
    ./guess-indent.nix
    ./hop.nix
    ./toggleterm.nix
  ];

  plugins = {
    luasnip.enable = true;
    nvim-autopairs.enable = true;
    comment-nvim = {
      enable = true;
      padding = true;
    };
    direnv.enable = true;
  };
}
