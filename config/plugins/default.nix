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
		comment-nvim.enable = true;
		rainbow-delimiters.enable = true;

		oil = {
			enable = true;
			keymaps = {
				"g?" = "actions.show_help";
				"<CR>" = "actions.select";
				"<C-s>" = "actions.select_vsplit";
				"<C-h>" = "actions.select_split";
				"<C-t>" = "actions.select_tab";
				"<C-p>" = "actions.preview";
				"<C-c>" = "actions.close";
				"<C-l>" = "actions.refresh";
				"-" = "actions.parent";
				"_" = "actions.open_cwd";
				"`" = "actions.cd";
				"~" = "actions.tcd";
				"gs" = "actions.change_sort";
				"gx" = "actions.open_external";
				"g." = "actions.toggle_hidden";
				"g\\" = "actions.toggle_trash";
			};
			defaultFileExplorer = true; # Replace netrw
			deleteToTrash = true;
			skipConfirmForSimpleEdits = true;
			bufOptions = {
				bufhidden = "hide";
				buflisted = false;
			};
			viewOptions = {
				showHidden = true;
				# Hide .git folders
				isAlwaysHidden = /*lua*/ ''
					function(name, bufnr)
						if name == ".git" then
							return true
						else
							return false
						end
					end
				'';
			};
			winOptions = {
				wrap = false;
				signcolumn = "no";
				cursorcolumn = false;
				foldcolumn = "0";
				spell = false;
				list = false;
				conceallevel = 3;
				concealcursor = "nvic";
			};
			columns = {
				icon.enable = true;
				# permissions.enable = true;
				# size.enable = true;
				# mtime.enable = true;
				# type.enable = true;
			};
		};

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

		(mkKeymap "n" "<leader>sr" ":SessionRestore<cr>")
		(mkKeymap "n" "<leader>ss" ":SessionSave<cr>")
		(mkKeymap "n" "<leader>sd" ":SessionDelete<cr>")
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
