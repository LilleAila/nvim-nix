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

	# TODO: sessions
	plugins = {
		lualine.enable = true;
		bufferline.enable = true;
		luasnip.enable = true;
		nvim-autopairs.enable = true;
		oil.enable = true;
		comment-nvim.enable = true;
		rainbow-delimiters.enable = true;

		indent-blankline = {
			enable = true;
			extraOptions = {
				indent = {
					char = "▍";
					smart_indent_cap = true;
				};
				scope = {
					enabled = true;
					show_start = false;
					show_end = false;
				};
			};
		};

		nvim-tree = {
			enable = true;
			hijackCursor = true;
			syncRootWithCwd = true;
		};

		auto-session = {
			enable = true;
			# :SessionRestore, :SessionSave
			autoRestore.enabled = false; # Only when `nvim` with no args
			autoSave.enabled = true;
			autoSession = {
				enabled = true;
				enableLastSession = true;
				createEnabled = true;
				useGitBranch = true;
			};
		};
	};

	keymaps = [
		(mkKeymap "n" "<leader>et" ":NvimTreeToggle<cr>")
		(mkKeymap "n" "<leader>ef" ":NvimTreeFocus<cr>")
		(mkKeymap "n" "<leader>er" ":NvimTreeRefresh<cr>")

		(mkKeymap "n" "<leader>ee" ":Oil<cr>")

		(mkKeymap "n" "<leader>sr" ":SessionRestore")
		(mkKeymap "n" "<leader>ss" ":SessionSave")
		(mkKeymap "n" "<leader>sd" ":SessionDelete")
	];

	plugins.which-key = {
		enable = true;
		registrations = {
			"<leader>t" = "Telescope";
			"<leader>tg" = "Git";
			"<leader>e" = "Explorer";
			"<leader>s" = "Sessions";
		};
		# ignoreMissing = true;
		triggersBlackList = {
			i = ["h" "j" "k" "l" "v"];
			v = ["h" "j" "k" "l"];
		};
	};

	plugins.noice = {
		enable = true;
		presets = {
			bottom_search = true;
			command_palette = false;
			long_message_to_split = true;
			inc_rename = false;
			lsp_doc_border = false;
		};
	};
}
