{
	imports = [
		./treesitter.nix
		./telescope.nix
	];

	colorschemes.gruvbox.enable = true;

	plugins = {
		lualine.enable = true;
		bufferline.enable = true;
		luasnip.enable = true;
		nvim-autopairs.enable = true;
		nvim-tree.enable = true;
		oil.enable = true;
		which-key.enable = true;
	};
}
