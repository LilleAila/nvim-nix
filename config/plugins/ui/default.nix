{ mkKeymap, ... }:
{
  imports = [
    ./buffers.nix
    ./lualine.nix
    ./noice.nix
    ./which-key.nix
    # ./fidget.nix
    ./colorscheme.nix
  ];

  plugins = {
    rainbow-delimiters.enable = true;
    nvim-colorizer.enable = true;
    nvim-tree = {
      enable = true;
      hijackCursor = true;
      syncRootWithCwd = true;
    };
  };

  keymaps = [
    (mkKeymap "n" "<leader>ft" ":NvimTreeToggle<cr>" "Toggle nvim tree")
    (mkKeymap "n" "<leader>fn" ":NvimTreeFocus<cr>" "Focus nvim tree")
    (mkKeymap "n" "<leader>fr" ":NvimTreeRefresh<cr>" "Refresh nvim tree")
  ];
}
