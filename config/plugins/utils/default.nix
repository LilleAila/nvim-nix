{...}: {
  imports = [
    ./oil.nix
    ./sessions.nix
    ./telescope.nix
    ./guess-indent.nix
    ./hop.nix
    ./toggleterm.nix
    ./img-clip.nix
    ./move.nix
    ./mini.nix
    ./luasnip
  ];

  plugins = {
    nvim-autopairs.enable = true;
    comment-nvim = {
      enable = true;
      padding = true;
    };
    direnv.enable = true;
  };
}
