{ ... }:
{
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
    direnv.enable = true;
  };
}
