{ ... }:
{
  imports = [
    ./oil.nix
    # ./sessions.nix
    ./telescope.nix
    # ./guess-indent.nix
    ./hop.nix
    ./toggleterm.nix
    ./img-clip.nix
    ./move.nix
    ./mini.nix
    ./luasnip
    ./autopairs.nix
    ./autotag.nix
    ./comment.nix
  ];

  plugins = {
    direnv.enable = true;
    plantuml-syntax.enable = true;
  };
}
