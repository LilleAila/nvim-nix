{
	plugins.telescope = {
		enable = true;
		extensions = {
			fzf-native.enable = true;
		};
		keymaps = {
			"<leader>tt" = {
				action = "find_files";
				desc = "Files";
			};
			"<leader>ts" = {
				action = "live_grep";
				desc = "Grep";
			};
			"<leader>tb" = {
				action = "buffers";
				desc = "Buffers";
			};
			"<leader>tr" = {
				action = "oldfiles";
				desc = "Recent files";
			};
			"<leader>tq" = {
				action = "quickfix";
				desc = "Quickfix";
			};

			"<leader>tgb" = {
				action = "git_branches";
				desc = "Branches";
			};
			"<leader>tgf" = {
				action = "git_files";
				desc = "Files";
			};
			"<leader>tgs" = {
				action = "git_status";
				desc = "Status";
			};
		};
	};
}
