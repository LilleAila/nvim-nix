{
  imports = [
		./options.nix
  ];

	colorschemes.gruvbox.enable = true;

	plugins.lualine.enable = true;
	plugins.bufferline.enable = true;

	plugins.lsp = {
		enable = true;
		servers = {
			tsserver.enable = true;
			lua-ls.enable = true;
		};
	};

	plugins.telescope.enable = true;
	plugins.oil.enable = true;
	plugins.treesitter.enable = true;
	plugins.luasnip.enable = true;
}
