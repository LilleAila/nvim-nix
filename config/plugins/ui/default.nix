{...}: {
  imports = [
    ./buffers.nix
    ./indent-blankline.nix
    ./lualine.nix
    ./noice.nix
    ./which-key.nix
    # ./fidget.nix
  ];

  plugins = {
    rainbow-delimiters.enable = true;
    nvim-colorizer.enable = true;
    gitsigns = {
      enable = true;
      currentLineBlame = true;
    };
  };
}
