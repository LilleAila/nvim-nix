{
	plugins.telescope = {
		enable = true;
		extensions = {
			fzf-native.enable = true;
		};
		keymaps = {
			"<leader>tt" = {
				action = "find_files";
				desc = "Telescope find files";
			};
			"<leader>ts" = {
				action = "live_grep";
				desc = "Telescope grep";
			};
			"<leader>tb" = {
				action = "buffers";
				desc = "Telescope buffers";
			};
			"<leader>tr" = {
				action = "oldfiles";
				desc = "Telescope recent files";
			};
			"<leader>tq" = {
				action = "quickfix";
				desc = "Telescope quickfix";
			};

			"<leader>tgb" = {
				action = "git_branches";
				desc = "Telescope git branches";
			};
			"<leader>tgf" = {
				action = "git_files";
				desc = "Telescope git files";
			};
			"<leader>tgs" = {
				action = "git_status";
				desc = "Telescope git status";
			};
		};
	};
}
