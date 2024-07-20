{
  inputs,
  pkgs,
  mkKeymap',
  ...
}:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "move.nvim";
      src = inputs.plugin-move;
    })
  ];

  extraConfigLua = ''
    require("move").setup({
      line = {
        enable = true,
        indent = true,
      },
      block = {
        enable = true,
        indent = true,
      },
      word = { enable = false, },
      char = { enable = false, },
    })
  '';

  keymaps = [
    (mkKeymap' "n" "<C-S-j>" ":MoveLine(1)<cr>")
    (mkKeymap' "n" "<C-S-k>" ":MoveLine(-1)<cr>")
    (mkKeymap' "i" "<C-S-j>" ":MoveLine(1)<cr>")
    (mkKeymap' "i" "<C-S-k>" ":MoveLine(-1)<cr>")
    (mkKeymap' "v" "<C-S-j>" ":MoveBlock(1)<cr>")
    (mkKeymap' "v" "<C-S-k>" ":MoveBlock(-1)<cr>")
  ];
}
