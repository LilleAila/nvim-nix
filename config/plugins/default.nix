{ mkKeymap, mkKeymapWithOpts, colorSchemePlugin, ... }:

{
	imports = [
		./treesitter.nix
		./telescope.nix
		./lsp.nix
		./cmp.nix
		./vimtex.nix
		./files.nix
		./sessions.nix
		./buffers.nix
	];

	# colorschemes.gruvbox.enable = true;

	extraPlugins = [
		colorSchemePlugin # From nix-colors
	];

	plugins = {
		luasnip.enable = true;
		nvim-autopairs.enable = true;
		comment-nvim.enable = true;
		rainbow-delimiters.enable = true;
		direnv.enable = true;

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

		lualine = {
			enable = true;
			globalstatus = true;
			iconsEnabled = true;
			# sectionSeparators = { left = ""; right = ""; };
			sectionSeparators = { left = ""; right = ""; };
			componentSeparators = { left = ""; right = ""; };
			sections = {
				lualine_a = [ "mode" ];
				lualine_b = [ "branch" "diff" "diagnostics" ];
				lualine_c = [ "filename" ];
				lualine_x = [ "encoding" "fileformat" "filetype" ];
				lualine_y = [ "progress" ];
				lualine_z = [ "location" ];
			};
		};
	};

	plugins.which-key = {
		enable = true;
		registrations = {
			"<leader>t" = "Telescope";
			"<leader>tg" = "Git";
			"<leader>s" = "Sessions";
		};
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
