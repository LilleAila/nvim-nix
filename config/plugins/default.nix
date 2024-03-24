{
	imports = [
		./treesitter.nix
		./telescope.nix
		./lsp.nix
		./cmp.nix
	];

	colorschemes.gruvbox.enable = true;

	plugins = {
		lualine.enable = true;
		bufferline.enable = true;
		luasnip.enable = true;
		nvim-autopairs.enable = true;
		oil.enable = true;
		which-key.enable = true;
		nvim-tree = {
			enable = true;
			hijackCursor = true;
			syncRootWithCwd = true;
		};
	};
}
