{ mkKeymap, mkKeymapWithOpts, ... }:

{
	imports = [
		./treesitter.nix
		./telescope.nix
		./lsp.nix
		./cmp.nix
		./vimtex.nix
	];

	colorschemes.gruvbox.enable = true;

	plugins = {
		lualine.enable = true;
		bufferline.enable = true;
		luasnip.enable = true;
		nvim-autopairs.enable = true;
		oil.enable = true;
		nvim-tree = {
			enable = true;
			hijackCursor = true;
			syncRootWithCwd = true;
		};
	};

	keymaps = [
		(mkKeymap "n" "<leader>et" ":NvimTreeToggle<cr>")
		(mkKeymap "n" "<leader>ef" ":NvimTreeFocus<cr>")
		(mkKeymap "n" "<leader>er" ":NvimTreeRefresh<cr>")

		(mkKeymap "n" "<leader>ee" ":Oil<cr>")
	];

	plugins.which-key = {
		enable = true;
		registrations = {
			"<leader>t" = "Telescope";
			"<leader>tg" = "Git";
			"<leader>e" = "Explorer";
		};
		# ignoreMissing = true;
		triggersBlackList = {
			i = ["h" "j" "k" "l" "v"];
			v = ["h" "j" "k" "l"];
		};
	};

	# plugins.noice = {
	# 	enable = true;
	# 	presets = {
	# 		bottom_search = true;
	# 		command_palette = false;
	# 		long_message_to_split = true;
	# 		inc_rename = false;
	# 		lsp_doc_border = false;
	# 	};
	# };
}
